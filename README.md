# 🚀 Script de Mise à Jour : Debian 12 → Debian 13 (Trixie)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Bash-5.0%2B-green.svg)](https://www.gnu.org/software/bash/)
[![Debian](https://img.shields.io/badge/Debian-12%20%E2%86%92%2013-red.svg)](https://www.debian.org/)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/TutoTech/Script-de-mise-a-jour-de-Debian-12-a-Debian-13/graphs/commit-activity)

> **Script automatisé et sécurisé pour migrer votre système Debian 12 (Bookworm) vers Debian 13 (Trixie) en toute sérénité.**

Conçu par des administrateurs système pour des administrateurs système, ce script automatise le processus de mise à jour tout en intégrant les meilleures pratiques de sécurité et les vérifications nécessaires.

---

## 📋 Table des matières

- [✨ Fonctionnalités](#-fonctionnalités)
- [⚠️ Avertissements importants](#️-avertissements-importants)
- [🚀 Installation rapide](#-installation-rapide)
- [📦 Installation manuelle](#-installation-manuelle)
- [🎯 Ce que fait le script](#-ce-que-fait-le-script)
- [🔍 Prérequis](#-prérequis)
- [📖 Guide d'utilisation détaillé](#-guide-dutilisation-détaillé)
- [🔒 Sécurité et sauvegardes](#-sécurité-et-sauvegardes)
- [💡 Cas d'usage](#-cas-dusage)
- [🐛 Résolution de problèmes](#-résolution-de-problèmes)
- [❓ FAQ](#-faq)
- [🤝 Contribution](#-contribution)
- [📄 Licence](#-licence)
- [👨‍💻 Auteur](#-auteur)

---

## ✨ Fonctionnalités

### 🎯 Mise à jour automatisée et sécurisée

- **✅ Vérifications préalables** : Espace disque, architecture, version Debian
- **✅ Sauvegarde des sources APT** : Backup automatique de votre configuration
- **✅ Mise à jour progressive** : Minimal upgrade puis full upgrade
- **✅ Gestion des redémarrages** : Instructions claires pour redémarrer
- **✅ Nettoyage post-upgrade** : Suppression des paquets obsolètes

### 🛡️ Sécurité et robustesse

- ✅ Vérification de l'espace disque disponible
- ✅ Détection des conflits de paquets
- ✅ Gestion des dépôts tiers
- ✅ Messages d'erreur détaillés
- ✅ Possibilité d'annuler avant le point de non-retour

### 🎨 Interface utilisateur

- 🌈 Messages colorés et informatifs
- 📊 Progression visible étape par étape
- ⚡ Avertissements clairs pour les actions critiques
- 🎭 Récapitulatif complet en fin de processus

---

## ⚠️ Avertissements importants

### 🚨 LISEZ CECI AVANT DE COMMENCER

<div align="center">

**⚠️ LA MISE À JOUR D'UN SYSTÈME DE PRODUCTION EST UNE OPÉRATION SENSIBLE**

</div>

Avant d'utiliser ce script :

1. **📸 Créez une sauvegarde complète** de votre système
2. **📋 Listez vos services critiques** et testez-les après la mise à jour
3. **🔌 Assurez-vous d'avoir un accès physique** au serveur (console ou KVM)
4. **⏰ Planifiez une fenêtre de maintenance** de 1 à 3 heures
5. **📖 Lisez les Release Notes officielles** de Debian 13 Trixie

### ⛔ Cas où vous NE devez PAS utiliser ce script

- ❌ Système en production critique sans sauvegarde
- ❌ Connexion SSH instable (risque de coupure)
- ❌ Pas d'accès physique ou console de secours
- ❌ Espace disque insuffisant (< 5 Go disponibles)
- ❌ Packages personnalisés ou compilés manuellement

### ✅ Cas où le script est adapté

- ✅ Serveurs de test et développement
- ✅ Machines virtuelles (avec snapshot préalable)
- ✅ Serveurs avec accès console/KVM
- ✅ Systèmes "vanilla" Debian avec peu de customisation
- ✅ Environnements pédagogiques et de formation

---

## 🚀 Installation rapide

### Installation et exécution en une seule commande

```bash
sudo -E bash -c 'f=$(mktemp) && curl -fsSL https://raw.githubusercontent.com/TutoTech/Script-de-mise-a-jour-de-Debian-12-a-Debian-13/main/upgrade-to-trixie.sh -o "$f" && chmod +x "$f" && "$f" && rm -f "$f"'
```

**⚠️ ATTENTION** : Cette commande télécharge et exécute immédiatement le script. Assurez-vous d'avoir :
- ✅ Créé une sauvegarde complète
- ✅ Lu les avertissements ci-dessus
- ✅ Vérifié que votre système est éligible

### 🔍 Détail de la commande

Cette commande one-liner effectue les opérations suivantes :

1. **`sudo -E`** : Exécute avec privilèges root en préservant l'environnement
2. **`bash -c '...'`** : Lance un nouveau shell bash pour la séquence
3. **`f=$(mktemp)`** : Crée un fichier temporaire sécurisé
4. **`curl -fsSL https://...`** : Télécharge le script depuis GitHub
   - `-f` : Échoue silencieusement en cas d'erreur HTTP
   - `-s` : Mode silencieux (pas de barre de progression)
   - `-S` : Affiche les erreurs malgré `-s`
   - `-L` : Suit les redirections
5. **`chmod +x "$f"`** : Rend le script exécutable
6. **`"$f"`** : Exécute le script de mise à jour
7. **`rm -f "$f"`** : Supprime le fichier temporaire

---

## 📦 Installation manuelle

Si vous préférez examiner le script avant de l'exécuter (recommandé pour production) :

```bash
# 1. Télécharger le script
curl -fsSL https://raw.githubusercontent.com/TutoTech/Script-de-mise-a-jour-de-Debian-12-a-Debian-13/main/upgrade-to-trixie.sh -o upgrade-to-trixie.sh

# 2. Examiner le contenu (important !)
less upgrade-to-trixie.sh

# 3. Rendre exécutable
chmod +x upgrade-to-trixie.sh

# 4. Exécuter avec sudo
sudo ./upgrade-to-trixie.sh
```

### Alternative : Cloner le dépôt

```bash
# Cloner le dépôt complet
git clone https://github.com/TutoTech/Script-de-mise-a-jour-de-Debian-12-a-Debian-13.git

# Entrer dans le répertoire
cd Script-de-mise-a-jour-de-Debian-12-a-Debian-13

# Examiner le script
cat upgrade-to-trixie.sh

# Exécuter
sudo ./upgrade-to-trixie.sh
```

---

## 🎯 Ce que fait le script

### Étapes du processus de mise à jour

Le script suit la procédure officielle de Debian en automatisant ces étapes :

#### 1️⃣ **Vérifications préalables**
- ✅ Vérification des privilèges root
- ✅ Confirmation que le système est bien Debian 12 (Bookworm)
- ✅ Vérification de l'espace disque disponible
- ✅ Détection des dépôts tiers problématiques

#### 2️⃣ **Préparation du système**
- 💾 Sauvegarde de `/etc/apt/sources.list`
- 💾 Sauvegarde des fichiers dans `/etc/apt/sources.list.d/`
- 📋 Création d'un rapport pré-upgrade

#### 3️⃣ **Mise à jour des paquets existants**
```bash
sudo apt update
sudo apt upgrade -y
sudo apt full-upgrade -y
```

#### 4️⃣ **Modification des sources APT**
- Remplacement de `bookworm` par `trixie` dans `/etc/apt/sources.list`
- Mise à jour des sources de sécurité et updates
- Gestion des sources non-Debian (commentaire automatique)

#### 5️⃣ **Mise à jour minimale**
```bash
sudo apt update
sudo apt upgrade --without-new-pkgs -y
```
Cette étape évite d'installer de nouveaux paquets trop tôt.

#### 6️⃣ **Mise à jour complète**
```bash
sudo apt full-upgrade -y
```
Installation complète de Debian 13 Trixie.

#### 7️⃣ **Nettoyage**
```bash
sudo apt autoremove -y
sudo apt autoclean -y
```

#### 8️⃣ **Redémarrage**
Instructions pour redémarrer le système et finaliser la mise à jour.

---

## 🔍 Prérequis

### Configuration minimale requise

| Composant | Minimum | Recommandé |
|-----------|---------|------------|
| **Espace disque** | 5 Go libres | 10 Go libres |
| **RAM** | 512 Mo | 1 Go |
| **Partition /boot** | 300 Mo libres | 500 Mo libres |
| **Connexion Internet** | Stable | Haut débit |

### Version Debian

- ✅ **Debian 12 (Bookworm)** : Supporté
- ❌ **Debian 11 (Bullseye)** : Mettre à jour vers Bookworm d'abord
- ❌ **Debian 10 (Buster)** : Mettre à jour vers Bookworm d'abord

**Vérifier votre version :**
```bash
cat /etc/debian_version
# Doit afficher : 12.x

lsb_release -a
# Codename: bookworm
```

### Architectures supportées

- ✅ **amd64** (x86_64) : Entièrement supporté
- ✅ **arm64** : Supporté
- ⚠️ **i386** : Support limité (legacy uniquement)
- ❌ **armel** : Non supporté dans Trixie

### Logiciels critiques

Vérifiez la compatibilité de vos logiciels critiques :

```bash
# Lister les paquets installés
dpkg -l | grep ^ii | awk '{print $2}' > packages-before-upgrade.txt

# Vérifier les dépôts tiers
ls -la /etc/apt/sources.list.d/
```

---

## 📖 Guide d'utilisation détaillé

### Étape 1 : Préparation (CRUCIAL)

#### A. Créer une sauvegarde complète

**Pour une VM (recommandé) :**
```bash
# Sur Proxmox
qm snapshot <vmid> pre-trixie-upgrade

# Sur VirtualBox
VBoxManage snapshot "VM Name" take "pre-trixie-upgrade"
```

**Pour un serveur physique :**
```bash
# Sauvegarde avec rsync
sudo rsync -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / /mnt/backup/

# Ou avec tar (plus rapide mais plus gros)
sudo tar -czpf /mnt/backup/debian-backup-$(date +%Y%m%d).tar.gz --exclude=/mnt --exclude=/proc --exclude=/sys /
```

#### B. Noter la configuration actuelle

```bash
# Lister les services actifs
systemctl list-units --type=service --state=running > services-running.txt

# Lister les packages installés
dpkg -l > packages-installed.txt

# Sauvegarder la config réseau
cp -r /etc/network /root/backup-network/
cp -r /etc/systemd/network /root/backup-systemd-network/
```

#### C. Informer les utilisateurs

Pour un serveur multi-utilisateurs :
```bash
# Message à tous les utilisateurs connectés
sudo wall "MAINTENANCE : Mise à jour Debian 12 → 13 dans 30 minutes. Sauvegardez vos travaux."
```

### Étape 2 : Lancement du script

```bash
# Se connecter en root ou avec sudo
sudo -i

# Lancer le script
./upgrade-to-trixie.sh
```

### Étape 3 : Pendant l'exécution

**Le script va :**
1. Afficher les vérifications préalables
2. Demander confirmation avant chaque étape critique
3. Afficher la progression en temps réel
4. Vous alerter en cas de problème

**Vous devrez :**
- ✅ Répondre "yes" ou "oui" aux confirmations
- ✅ Surveiller les messages d'erreur
- ✅ Noter tout comportement anormal

**⏱️ Durée estimée :**
- Petit serveur (< 500 paquets) : 15-30 minutes
- Serveur moyen (500-1000 paquets) : 30-60 minutes
- Gros serveur (> 1000 paquets) : 1-2 heures

### Étape 4 : Après la mise à jour

#### A. Redémarrer le système

```bash
# Redémarrage immédiat
sudo reboot

# Ou redémarrage planifié (dans 2 minutes)
sudo shutdown -r +2 "Redémarrage pour finaliser la mise à jour Debian 13"
```

#### B. Vérifier la version

```bash
# Vérifier la version Debian
cat /etc/debian_version
# Doit afficher : 13.x ou trixie/sid

# Vérifier le nom de code
lsb_release -cs
# Doit afficher : trixie

# Vérifier la version du kernel
uname -r
# Devrait être 6.1.x ou supérieur
```

#### C. Vérifier les services

```bash
# Vérifier que tous les services sont actifs
systemctl --failed

# Comparer avec la liste pré-upgrade
systemctl list-units --type=service --state=running > services-running-after.txt
diff services-running.txt services-running-after.txt

# Vérifier les logs pour les erreurs
journalctl -p err -b
```

#### D. Tests fonctionnels

```bash
# Tester la connexion réseau
ping -c 4 google.com

# Tester apt
sudo apt update
sudo apt upgrade

# Tester vos services critiques
sudo systemctl status nginx
sudo systemctl status postgresql
sudo systemctl status docker
# etc.
```

---

## 🔒 Sécurité et sauvegardes

### 🛡️ Stratégie de sauvegarde recommandée

#### Option 1 : Snapshot de VM (RECOMMANDÉ pour production)

**Avantages :**
- ✅ Retour arrière instantané
- ✅ Pas d'impact sur l'espace disque du système
- ✅ Testé et fiable

**Proxmox :**
```bash
# Créer un snapshot
qm snapshot 100 pre-trixie-upgrade --description "Avant upgrade Debian 13"

# Restaurer si nécessaire
qm rollback 100 pre-trixie-upgrade
```

**VMware ESXi :**
```bash
# Via vSphere Client : VM → Snapshot → Take Snapshot
```

#### Option 2 : Clonage de VM

```bash
# Proxmox - Cloner la VM
qm clone 100 200 --name "vm-backup-pre-trixie"

# La VM originale reste intacte, clone pour test
```

#### Option 3 : Sauvegarde système complète

**Avec Timeshift (recommandé pour desktop) :**
```bash
# Installer timeshift
sudo apt install timeshift

# Créer un snapshot
sudo timeshift --create --comments "Pre Debian 13 upgrade"

# Restaurer si problème
sudo timeshift --restore
```

**Avec rsync :**
```bash
#!/bin/bash
# Script de sauvegarde
BACKUP_DIR="/mnt/backup/debian-$(date +%Y%m%d)"
mkdir -p "$BACKUP_DIR"

sudo rsync -aAXv \
  --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} \
  / "$BACKUP_DIR/"

echo "Sauvegarde terminée : $BACKUP_DIR"
```

### 🔐 Points de rollback

Le script crée des sauvegardes automatiques à ces points :

1. **Avant modification des sources** : `/etc/apt/sources.list.backup-YYYYMMDD`
2. **Avant upgrade** : `/root/pre-trixie-upgrade/` (liste des paquets)

---

## 💡 Cas d'usage

### Cas 1 : Serveur de développement

```bash
# 1. Créer un snapshot
ssh user@dev-server
sudo -i

# 2. Lancer la mise à jour
curl -fsSL https://raw.githubusercontent.com/TutoTech/Script-de-mise-a-jour-de-Debian-12-a-Debian-13/main/upgrade-to-trixie.sh | sudo bash

# 3. Tester après redémarrage
systemctl status nginx
```

### Cas 2 : Fleet de serveurs (avec Ansible)

```yaml
# playbook-upgrade-trixie.yml
- hosts: debian_servers
  become: yes
  serial: 1  # Un serveur à la fois
  tasks:
    - name: Download upgrade script
      get_url:
        url: https://raw.githubusercontent.com/TutoTech/Script-de-mise-a-jour-de-Debian-12-a-Debian-13/main/upgrade-to-trixie.sh
        dest: /tmp/upgrade-to-trixie.sh
        mode: '0755'

    - name: Run upgrade script
      command: /tmp/upgrade-to-trixie.sh
      register: upgrade_result

    - name: Reboot server
      reboot:
        reboot_timeout: 600

    - name: Verify upgrade
      command: cat /etc/debian_version
      register: debian_version

    - name: Display version
      debug:
        msg: "Debian version: {{ debian_version.stdout }}"
```

### Cas 3 : Environnement pédagogique (multiple VMs)

```bash
# Script pour upgrader plusieurs VMs Proxmox
#!/bin/bash
VMS="101 102 103 104 105"

for vm in $VMS; do
  echo "=== Upgrade VM $vm ==="
  
  # Snapshot
  qm snapshot $vm pre-trixie
  
  # Lancer l'upgrade
  ssh root@vm-$vm "bash <(curl -fsSL https://raw.githubusercontent.com/TutoTech/Script-de-mise-a-jour-de-Debian-12-a-Debian-13/main/upgrade-to-trixie.sh)"
  
  # Attendre et redémarrer
  sleep 60
  qm reboot $vm
  
  echo "VM $vm : upgrade terminé"
done
```

---

## 🐛 Résolution de problèmes

### Problème 1 : Espace disque insuffisant

**Symptôme :**
```
E: You don't have enough free space in /var/cache/apt/archives/
```

**Solution :**
```bash
# Nettoyer le cache apt
sudo apt clean

# Supprimer les anciens kernels
sudo apt autoremove --purge

# Vérifier l'espace
df -h /

# Si toujours insuffisant, étendre la partition
```

### Problème 2 : Paquets cassés

**Symptôme :**
```
E: Unmet dependencies. Try 'apt --fix-broken install'
```

**Solution :**
```bash
# Réparer les dépendances
sudo apt --fix-broken install

# Forcer la configuration des paquets
sudo dpkg --configure -a

# Relancer l'upgrade
sudo apt full-upgrade
```

### Problème 3 : Sources list corrompues

**Symptôme :**
```
E: Malformed entry 1 in list file /etc/apt/sources.list
```

**Solution :**
```bash
# Restaurer la sauvegarde
sudo cp /etc/apt/sources.list.backup-* /etc/apt/sources.list

# Éditer manuellement
sudo nano /etc/apt/sources.list

# Remplacer bookworm par trixie
:%s/bookworm/trixie/g  # dans vim
```

### Problème 4 : Le système ne démarre plus

**Solution (mode rescue) :**

1. Démarrer sur un live CD/USB Debian 13
2. Monter votre système :
```bash
sudo mount /dev/sda1 /mnt
sudo mount --bind /dev /mnt/dev
sudo mount --bind /proc /mnt/proc
sudo mount --bind /sys /mnt/sys
sudo chroot /mnt
```

3. Réparer GRUB :
```bash
update-grub
grub-install /dev/sda
```

4. Vérifier fstab :
```bash
nano /etc/fstab
```

### Problème 5 : Services qui ne démarrent pas

**Symptôme :**
```
Failed to start <service-name>.service
```

**Solution :**
```bash
# Vérifier les logs
journalctl -u service-name.service -n 50

# Vérifier la configuration
systemctl status service-name

# Réinstaller le package
sudo apt install --reinstall package-name

# Réinitialiser la configuration
sudo systemctl reset-failed
sudo systemctl restart service-name
```

---

## ❓ FAQ

### Questions générales

<details>
<summary><b>Q : Combien de temps prend la mise à jour ?</b></summary>

**R :** Cela dépend de plusieurs facteurs :
- **Petit serveur** (< 500 paquets) : 15-30 minutes
- **Serveur moyen** (500-1000 paquets) : 30-60 minutes  
- **Gros serveur** (> 1000 paquets) : 1-2 heures
- **Connexion Internet** : Plus c'est rapide, moins ça prend de temps

La partie la plus longue est généralement le téléchargement des paquets.
</details>

<details>
<summary><b>Q : Puis-je utiliser ce script sur Debian 11 (Bullseye) ?</b></summary>

**R :** Non. Vous devez d'abord mettre à jour vers Debian 12 (Bookworm), puis vers Debian 13 (Trixie). Les mises à jour doivent être séquentielles.

```bash
# Ordre correct :
Debian 11 (Bullseye) → Debian 12 (Bookworm) → Debian 13 (Trixie)
```
</details>

<details>
<summary><b>Q : Que faire si la connexion SSH est coupée pendant l'upgrade ?</b></summary>

**R :** C'est pour cela qu'il est **CRUCIAL** d'avoir un accès console (KVM, IPMI, accès physique). Si la connexion est coupée :

1. Accédez via console
2. Le script devrait continuer à tourner
3. Si bloqué, reprenez manuellement :
```bash
sudo apt full-upgrade
sudo reboot
```
</details>

<details>
<summary><b>Q : Mes configurations personnalisées seront-elles conservées ?</b></summary>

**R :** Oui, en général. Pendant l'upgrade, apt vous demandera pour chaque fichier de configuration modifié :
- **Garder votre version** (recommandé dans la plupart des cas)
- **Installer la nouvelle version**
- **Voir les différences**

Choisissez selon votre cas.
</details>

### Questions techniques

<details>
<summary><b>Q : Le script fonctionne-t-il sur des architectures ARM (Raspberry Pi) ?</b></summary>

**R :** Oui, tant que vous utilisez Debian officiel (pas Raspbian). Le script fonctionne sur :
- ✅ amd64 (x86_64)
- ✅ arm64 (64-bit ARM)
- ⚠️ armhf (32-bit ARM - support limité)
</details>

<details>
<summary><b>Q : Que faire avec les dépôts tiers (Docker, Google Chrome, etc.) ?</b></summary>

**R :** Le script les détecte automatiquement. Options :
1. **Les laisser** : La plupart continuent de fonctionner
2. **Les désactiver temporairement** : Le script peut le faire automatiquement
3. **Les mettre à jour manuellement** après l'upgrade

Exemple pour Docker :
```bash
# Après l'upgrade, mettre à jour le dépôt Docker
sudo apt-get remove docker docker-engine docker.io containerd runc
curl -fsSL https://get.docker.com | sh
```
</details>

<details>
<summary><b>Q : Comment vérifier que la mise à jour a réussi ?</b></summary>

**R :** Plusieurs vérifications :
```bash
# 1. Version Debian
cat /etc/debian_version
# Doit afficher 13.x

# 2. Nom de code
lsb_release -cs
# Doit afficher: trixie

# 3. Kernel
uname -r
# Doit être 6.1.x ou supérieur

# 4. Aucun paquet cassé
dpkg -l | grep ^..r

# 5. Aucun service en échec
systemctl --failed
```
</details>

<details>
<summary><b>Q : Puis-je annuler la mise à jour une fois commencée ?</b></summary>

**R :** 
- **AVANT** `apt full-upgrade` : OUI, vous pouvez Ctrl+C et restaurer les sources
- **PENDANT** `apt full-upgrade` : NON, laissez terminer
- **APRÈS** : Utilisez votre sauvegarde/snapshot pour revenir en arrière
</details>

### Problèmes spécifiques

<details>
<summary><b>Q : Erreur "Release file is not valid yet"</b></summary>

**R :** Votre horloge système n'est pas à l'heure :
```bash
# Vérifier la date
date

# Synchroniser avec NTP
sudo apt install systemd-timesyncd
sudo timedatectl set-ntp true

# Ou manuellement
sudo date -s "2026-02-11 14:30:00"
```
</details>

<details>
<summary><b>Q : Mon interface réseau ne fonctionne plus après reboot</b></summary>

**R :** Debian 13 peut avoir changé les noms d'interfaces. Vérifier :
```bash
# Lister les interfaces
ip link show

# Mettre à jour /etc/network/interfaces si nécessaire
sudo nano /etc/network/interfaces

# Redémarrer le service réseau
sudo systemctl restart networking
```
</details>

---

## 🤝 Contribution

Les contributions sont bienvenues ! Voici comment participer :

### Signaler un problème

1. Vérifiez que le problème n'est pas déjà reporté dans les [Issues](https://github.com/TutoTech/Script-de-mise-a-jour-de-Debian-12-a-Debian-13/issues)
2. Créez une nouvelle issue avec :
   - Description du problème
   - Version de Debian avant upgrade
   - Architecture (amd64, arm64, etc.)
   - Logs pertinents
   - Étapes pour reproduire

### Proposer une amélioration

1. Forkez le dépôt
2. Créez une branche (`git checkout -b feature/AmazingFeature`)
3. Committez vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Pushez vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

### Standards de code

- ✅ Code bash conforme à [ShellCheck](https://www.shellcheck.net/)
- ✅ Commentaires en français
- ✅ Vérifications d'erreur systématiques
- ✅ Messages utilisateur clairs et informatifs
- ✅ Testé sur au moins 2 environnements différents

---

## 🧪 Tests

### Environnements testés

Le script a été testé avec succès sur :

- ✅ **Debian 12.8 amd64** → Debian 13 Trixie (serveur bare-metal)
- ✅ **Debian 12.7 amd64** → Debian 13 Trixie (VM Proxmox)
- ✅ **Debian 12.8 arm64** → Debian 13 Trixie (Raspberry Pi 4)
- ✅ **Debian 12.6 amd64** → Debian 13 Trixie (VirtualBox)

### Configurations testées

| Configuration | Résultat | Notes |
|---------------|----------|-------|
| Serveur web (nginx) | ✅ OK | Aucun problème |
| Serveur mail (Postfix) | ✅ OK | Config préservée |
| Base de données (PostgreSQL) | ✅ OK | Redémarrage requis |
| Docker CE | ⚠️ À tester | Peut nécessiter réinstallation |
| Proxmox VE | ❌ Non supporté | Utiliser upgrade officiel Proxmox |

### Protocole de test recommandé

```bash
# 1. Créer une VM de test
# 2. Installer Debian 12
# 3. Configurer vos services habituels
# 4. Créer un snapshot
# 5. Lancer le script
# 6. Vérifier tous les services
# 7. Si OK → appliquer en production
```

---

## 📄 Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.

### En résumé

✅ **Vous pouvez** :
- Utiliser ce script à des fins commerciales ou personnelles
- Modifier le code selon vos besoins
- Distribuer le script original ou modifié

✅ **Vous devez** :
- Inclure une copie de la licence MIT
- Inclure l'avis de copyright

❌ **Limitations** :
- Aucune garantie fournie
- Les auteurs ne sont pas responsables des dommages

---

## 👨‍💻 Auteur

**Nicolas BODAINE**
- 🏢 Organisation : [TutoTech](https://github.com/TutoTech)
- 📧 Contact : [Via GitHub Issues](https://github.com/TutoTech/Script-de-mise-a-jour-de-Debian-12-a-Debian-13/issues)
- 🎓 Contexte : Formateur en systèmes et réseaux

### Remerciements

- 🙏 **La communauté Debian** pour l'excellente documentation
- 🙏 **L'équipe TutoTech** pour les tests et retours
- 🙏 **Les testeurs beta** qui ont remonté des bugs avant la release

---

## 📚 Ressources complémentaires

### Documentation officielle

- [Release Notes Debian 13 Trixie](https://www.debian.org/releases/trixie/releasenotes)
- [Guide de mise à jour officiel](https://www.debian.org/releases/trixie/amd64/release-notes/ch-upgrading.html)
- [Debian Wiki - Upgrade](https://wiki.debian.org/DebianUpgrade)

### Guides recommandés

- [Préparation à la mise à jour](https://www.debian.org/releases/stable/amd64/release-notes/ch-information.html)
- [Gestion des problèmes](https://www.debian.org/releases/stable/amd64/release-notes/ch-about.html#trouble)
- [Nouveautés Debian 13](https://www.debian.org/releases/trixie/amd64/release-notes/ch-whats-new.html)

### Outils utiles

- [Debian Package Tracker](https://tracker.debian.org/)
- [Debian Security Tracker](https://security-tracker.debian.org/)
- [aptitude](https://wiki.debian.org/Aptitude) - Alternative avancée à apt

---

## 📊 Statistiques

![GitHub stars](https://img.shields.io/github/stars/TutoTech/Script-de-mise-a-jour-de-Debian-12-a-Debian-13?style=social)
![GitHub forks](https://img.shields.io/github/forks/TutoTech/Script-de-mise-a-jour-de-Debian-12-a-Debian-13?style=social)
![GitHub issues](https://img.shields.io/github/issues/TutoTech/Script-de-mise-a-jour-de-Debian-12-a-Debian-13)
![GitHub pull requests](https://img.shields.io/github/issues-pr/TutoTech/Script-de-mise-a-jour-de-Debian-12-a-Debian-13)

---

## 🌟 Support

Si ce script vous a été utile, n'hésitez pas à :

- ⭐ Mettre une étoile au projet
- 🐛 Signaler des bugs
- 💡 Proposer des améliorations
- 📣 Partager avec la communauté

---

## ⚡ Changelog

### Version 1.0.0 (2026-02-11)
- ✨ Release initiale
- ✅ Support Debian 12 → 13
- ✅ Vérifications automatiques
- ✅ Sauvegarde des sources
- ✅ Interface colorée

---

<div align="center">

**Fait avec ❤️ par la communauté TutoTech**

**⚠️ Effectuez toujours une sauvegarde avant toute mise à jour majeure ⚠️**

[⬆ Retour en haut](#-script-de-mise-à-jour--debian-12--debian-13-trixie)

</div>
