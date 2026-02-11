#!/bin/bash

#############################################################################
# Script de mise à niveau Debian 12 (Bookworm) vers Debian 13 (Trixie)
# Basé sur la documentation officielle Debian
# Date: Février 2026
#############################################################################

set -e  # Arrêter le script en cas d'erreur

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Vérifier que le script est exécuté en tant que root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}Ce script doit être exécuté en tant que root${NC}" 
   exit 1
fi

# Fonction pour afficher les messages
print_step() {
    echo -e "\n${BLUE}==>${NC} ${GREEN}$1${NC}\n"
}

print_warning() {
    echo -e "${YELLOW}ATTENTION: $1${NC}"
}

print_error() {
    echo -e "${RED}ERREUR: $1${NC}"
}

# Fonction pour demander confirmation
ask_confirmation() {
    while true; do
        read -p "$1 [o/N] " response
        case $response in
            [oO]|[oO][uU][iI]) return 0 ;;
            [nN]|"") return 1 ;;
            *) echo "Réponse invalide. Veuillez répondre 'o' ou 'n'." ;;
        esac
    done
}

# Vérifier la version actuelle de Debian
print_step "Vérification de la version Debian actuelle..."
current_version=$(cat /etc/debian_version)
echo "Version Debian actuelle : $current_version"

if [[ ! "$current_version" =~ ^12\. ]]; then
    print_error "Ce script est conçu pour la mise à niveau depuis Debian 12 (Bookworm)."
    print_error "Version détectée : $current_version"
    exit 1
fi

echo -e "\n${YELLOW}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║  MISE À NIVEAU DEBIAN 12 (BOOKWORM) → DEBIAN 13 (TRIXIE)     ║${NC}"
echo -e "${YELLOW}╚═══════════════════════════════════════════════════════════════╝${NC}\n"

print_warning "Ce processus va mettre à niveau votre système complet."
print_warning "Il est FORTEMENT recommandé d'avoir :"
echo "  - Une sauvegarde complète de vos données"
echo "  - Une sauvegarde de /etc, /var/lib/dpkg, /var/lib/apt/extended_states"
echo "  - Au moins 5 GB d'espace disque libre sur /"
echo ""

if ! ask_confirmation "Avez-vous fait une sauvegarde complète ?"; then
    print_error "Faites une sauvegarde avant de continuer !"
    exit 1
fi

if ! ask_confirmation "Voulez-vous continuer avec la mise à niveau ?"; then
    echo "Opération annulée."
    exit 0
fi

# Vérifier l'espace disque disponible
print_step "Vérification de l'espace disque..."
root_space=$(df -h / | awk 'NR==2 {print $4}')
echo "Espace disque disponible sur / : $root_space"

root_space_gb=$(df -BG / | awk 'NR==2 {print $4}' | sed 's/G//')
if [[ $root_space_gb -lt 5 ]]; then
    print_warning "Moins de 5 GB disponibles sur /. La mise à niveau pourrait échouer."
    if ! ask_confirmation "Voulez-vous continuer malgré tout ?"; then
        exit 1
    fi
fi

# Installation de screen si non présent
print_step "Vérification de screen (pour éviter les interruptions)..."
if ! command -v screen &> /dev/null; then
    print_warning "Installation de screen pour sécuriser la session..."
    apt update
    apt install -y screen
fi

# Vérifier les paquets en hold
print_step "Vérification des paquets bloqués (hold)..."
held_packages=$(apt-mark showhold)
if [[ -n "$held_packages" ]]; then
    print_warning "Paquets bloqués détectés :"
    echo "$held_packages"
    if ! ask_confirmation "Voulez-vous continuer ? (Ces paquets ne seront pas mis à jour)"; then
        exit 1
    fi
fi

# Audit du système de paquets
print_step "Audit de l'état des paquets..."
if ! dpkg --audit; then
    print_error "Des problèmes ont été détectés avec le système de paquets."
    if ask_confirmation "Voulez-vous tenter de corriger automatiquement ?"; then
        apt --fix-broken install
        dpkg --configure -a
    else
        exit 1
    fi
fi

# Mise à jour complète de Bookworm
print_step "Mise à jour complète de Debian 12 (Bookworm)..."
apt update
apt upgrade -y
apt full-upgrade -y

# Nettoyage
print_step "Nettoyage du système..."
apt autoremove -y
apt clean

# Sauvegarde des sources APT
print_step "Sauvegarde de la configuration APT..."
backup_dir="/root/debian-upgrade-backup-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$backup_dir"
cp -r /etc/apt "$backup_dir/"
echo "Sauvegarde créée dans : $backup_dir"

# Modification des sources pour Trixie
print_step "Configuration des sources APT pour Debian 13 (Trixie)..."

# Création du nouveau fichier sources au format deb822
cat > /etc/apt/sources.list.d/debian.sources << 'EOF'
Types: deb
URIs: http://deb.debian.org/debian
Suites: trixie trixie-updates
Components: main non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb
URIs: http://security.debian.org/debian-security
Suites: trixie-security
Components: main non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF

# Désactiver les anciennes sources
if [[ -f /etc/apt/sources.list ]]; then
    mv /etc/apt/sources.list /etc/apt/sources.list.bookworm.backup
    echo "# Fichier désactivé - voir /etc/apt/sources.list.d/debian.sources" > /etc/apt/sources.list
fi

# Désactiver les anciennes sources list dans sources.list.d
for file in /etc/apt/sources.list.d/*.list; do
    if [[ -f "$file" ]]; then
        mv "$file" "$file.backup"
    fi
done

echo "Configuration APT mise à jour vers Trixie"

# Mise à jour de la liste des paquets
print_step "Mise à jour de la liste des paquets depuis Trixie..."
apt update

# Afficher les paquets qui seront mis à jour
print_step "Aperçu des paquets à mettre à niveau..."
apt list --upgradable | head -n 20
upgradable_count=$(apt list --upgradable 2>/dev/null | grep -c "upgradable")
echo -e "\nTotal de paquets à mettre à niveau : ${GREEN}$upgradable_count${NC}"

if ! ask_confirmation "Voulez-vous procéder à la mise à niveau minimale ?"; then
    print_error "Opération annulée."
    exit 1
fi

# Mise à niveau minimale
print_step "Étape 1/2 : Mise à niveau minimale du système..."
apt upgrade --without-new-pkgs -y

# Mise à niveau complète
print_step "Étape 2/2 : Mise à niveau complète du système..."
print_warning "Cette étape peut prendre du temps et installer/supprimer des paquets."

if ! ask_confirmation "Lancer la mise à niveau complète maintenant ?"; then
    print_error "Opération annulée. Relancez le script pour terminer."
    exit 1
fi

# Tenter la mise à niveau complète
if ! apt full-upgrade -y; then
    print_warning "La mise à niveau a rencontré une erreur. Tentative de correction..."
    # Tentative avec configuration immédiate désactivée
    apt full-upgrade -y -o APT::Immediate-Configure=0 || {
        print_error "La mise à niveau a échoué. Consultez les logs dans /var/log/apt/"
        exit 1
    }
fi

# Nettoyage final
print_step "Nettoyage post-mise à niveau..."
apt autoremove -y
apt autoclean

# Vérification finale
print_step "Vérification de la nouvelle version..."
new_version=$(cat /etc/debian_version)
echo "Version Debian installée : $new_version"

# Résumé
echo -e "\n${GREEN}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║           MISE À NIVEAU TERMINÉE AVEC SUCCÈS !                ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════╝${NC}\n"

echo "Version précédente : Debian $current_version (Bookworm)"
echo "Version actuelle   : Debian $new_version (Trixie)"
echo ""
print_warning "REDÉMARRAGE NÉCESSAIRE pour finaliser la mise à niveau !"
echo ""

if ask_confirmation "Voulez-vous redémarrer maintenant ?"; then
    echo "Redémarrage dans 5 secondes..."
    sleep 5
    reboot
else
    print_warning "N'oubliez pas de redémarrer le système dès que possible !"
    echo "Commande : sudo reboot"
fi
