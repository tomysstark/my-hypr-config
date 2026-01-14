#!/bin/bash

# Script d'installation pour ma config Arch + Caelestia modifiée
# Par: Tomy Stark

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "╔════════════════════════════════════════════════╗"
echo "║   Installation de ma config Arch modifiée      ║"
echo "║   Basé sur Caelestia + Starrynight + AZERTY    ║"
echo "╚════════════════════════════════════════════════╝"
echo ""

# Vérifier qu'on est sur Arch
if ! command -v pacman &> /dev/null; then
    echo -e "${RED}Erreur: Ce script nécessite Arch Linux${NC}"
    exit 1
fi

echo -e "${BLUE}[1/9]${NC} Mise à jour du système..."
sudo pacman -Syu --noconfirm

echo -e "${BLUE}[2/9]${NC} Installation de yay (AUR helper)..."
if ! command -v yay &> /dev/null; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd -
fi

echo -e "${BLUE}[3/9]${NC} Installation des dépendances de base..."
sudo pacman -S --needed --noconfirm \
    hyprland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
    waybar swww hyprpicker wl-clipboard cliphist \
    foot fish starship fastfetch btop \
    neovim git base-devel \
    networkmanager nm-applet \
    ttf-jetbrains-mono-nerd papirus-icon-theme \
    grim slurp

echo -e "${BLUE}[4/9]${NC} Installation de caelestia-shell et caelestia-cli..."
yay -S --noconfirm caelestia-shell caelestia-cli

echo -e "${BLUE}[5/9]${NC} Installation des configurations Hyprland..."
mkdir -p ~/.config

# Backup si existe déjà
if [ -d ~/.config/hypr ] && [ ! -L ~/.config/hypr ]; then
    echo "Sauvegarde de l'ancienne config Hyprland..."
    mv ~/.config/hypr ~/.config/hypr.backup.$(date +%s)
fi

ln -sf "$(pwd)/hypr" ~/.config/hypr

echo -e "${BLUE}[6/9]${NC} Installation de Fish, Fastfetch, Foot et Btop..."

# Backup et symlink pour chaque config
for config_dir in fish fastfetch foot btop; do
    if [ -d ~/.config/$config_dir ] && [ ! -L ~/.config/$config_dir ]; then
        echo "Sauvegarde de ~/.config/$config_dir..."
        mv ~/.config/$config_dir ~/.config/${config_dir}.backup.$(date +%s)
    fi
    ln -sf "$(pwd)/$config_dir" ~/.config/$config_dir
done

# Starship
if [ -f ~/.config/starship.toml ] && [ ! -L ~/.config/starship.toml ]; then
    mv ~/.config/starship.toml ~/.config/starship.toml.backup.$(date +%s)
fi
ln -sf "$(pwd)/starship.toml" ~/.config/starship.toml

# Changer le shell par défaut en Fish
if [ "$SHELL" != "/bin/fish" ] && [ "$SHELL" != "/usr/bin/fish" ]; then
    echo -e "${BLUE}Changement du shell par défaut vers Fish...${NC}"
    chsh -s /usr/bin/fish
fi

echo -e "${BLUE}[7/9]${NC} Installation du wallpaper..."
mkdir -p ~/Pictures
if [ -d "wallpapers" ] && [ "$(ls -A wallpapers/*.png 2>/dev/null)" ]; then
    cp wallpapers/*.png ~/Pictures/
    
    # Configurer swww pour le wallpaper
    WALLPAPER=$(ls ~/Pictures/*.png | head -n 1)
    if ! grep -q "exec-once = swww-daemon" ~/.config/hypr/hyprland.conf; then
        echo "exec-once = swww-daemon" >> ~/.config/hypr/hyprland.conf
        echo "exec-once = swww img $WALLPAPER" >> ~/.config/hypr/hyprland.conf
    fi
fi

echo -e "${BLUE}[8/9]${NC} Installation de la config Neovim..."
# Sauvegarder l'ancienne config nvim si elle existe
if [ -d ~/.config/nvim ] && [ ! -L ~/.config/nvim ]; then
    echo "Sauvegarde de l'ancienne config Neovim..."
    mv ~/.config/nvim ~/.config/nvim.backup.$(date +%s)
fi

# Créer le symlink vers la config nvim du repo
ln -sf "$(pwd)/nvim" ~/.config/nvim

echo -e "${BLUE}[9/9]${NC} Installation optionnelle des applications..."
echo ""

# Zen Browser
read -p "Installer Zen Browser ? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    yay -S --noconfirm zen-browser-bin
fi

# VSCode
read -p "Installer VSCode ? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    yay -S --noconfirm visual-studio-code-bin
fi

# Spotify + Spicetify
read -p "Installer Spotify avec Spicetify (thème Starrynight) ? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    yay -S --noconfirm spotify spicetify-cli
    
    # Backup et symlink spicetify
    if [ -d ~/.config/spicetify ] && [ ! -L ~/.config/spicetify ]; then
        mv ~/.config/spicetify ~/.config/spicetify.backup.$(date +%s)
    fi
    ln -sf "$(pwd)/spicetify" ~/.config/spicetify
    
    # Appliquer le thème
    spicetify backup apply
    spicetify config current_theme Starrynight
    spicetify apply
fi

# Discord
read -p "Installer Discord (Vesktop) ? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    yay -S --noconfirm vesktop-bin
fi

# Caffeine (anti-veille)
echo ""
echo -e "${BLUE}Installation de Caffeine (anti-veille vidéos)...${NC}"
yay -S --noconfirm caffeine-ng
if ! grep -q "exec-once = caffeine" ~/.config/hypr/hyprland.conf; then
    echo "exec-once = caffeine 2>/dev/null" >> ~/.config/hypr/hyprland.conf
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║        ✓ Installation terminée !               ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Pour démarrer Hyprland:${NC} tapez 'Hyprland' dans le terminal"
echo ""
echo -e "${BLUE}Raccourcis principaux:${NC}"
echo "  Super          - Launcher"
echo "  Super + T      - Terminal"
echo "  Super + W      - Navigateur"
echo "  Super + C      - VSCode"
echo ""
echo -e "${GREEN}Profitez de votre nouvelle installation ! 🚀${NC}"
echo ""
echo -e "${BLUE}Note:${NC} Les anciennes configs ont été sauvegardées avec l'extension .backup"
