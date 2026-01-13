# 🌙 My Hyprland Configuration

> A custom Arch Linux rice based on Caelestia with Starrynight theme, AZERTY layout, and LazyVim

[![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![Hyprland](https://img.shields.io/badge/Hyprland-00ADD8?style=for-the-badge&logo=wayland&logoColor=white)](https://hyprland.org/)

## ✨ Features

- 🎨 **Hyprland** - Modern Wayland compositor
- 🌌 **Caelestia** - Beautiful base configuration (modified)
- ⭐ **Starrynight** - Spicetify theme for Spotify
- ⌨️ **AZERTY** - French keyboard layout configured
- 📝 **LazyVim** - Neovim with modern IDE features
- 🎯 **Custom keybinds** - Personalized Hyprland shortcuts
- 🖼️ **Custom wallpaper** - Unique background
- 🐚 **Fish Shell** - Modern shell with Starship prompt
- 📊 **Fastfetch** - System info with Arch logo

## 📦 What's Included

### Core System
- **Window Manager**: Hyprland
- **Shell**: Fish + Starship
- **Terminal**: Foot
- **Status Bar**: Waybar (via Caelestia)
- **Launcher**: Caelestia Shell
- **Lock Screen**: Hyprlock

### Applications
- **Browser**: Zen Browser (optional)
- **IDE**: VSCode (optional)
- **Music**: Spotify + Spicetify + Starrynight theme (optional)
- **Communication**: Discord/Vesktop (optional)
- **Editor**: Neovim + LazyVim

### Tools & Utilities
- **System Monitor**: Btop
- **Wallpaper**: Swww
- **Screenshots**: Grim + Slurp
- **Clipboard**: Cliphist
- **Color Picker**: Hyprpicker
- **Anti-sleep**: Caffeine

## 🚀 Installation

### Prerequisites

- Arch Linux or Arch-based distribution
- Internet connection
- `git` installed

### Quick Install

```bash
# Clone the repository
git clone https://github.com/tomysstark/my-hypr-config.git
cd my-hypr-config

# Make the install script executable
chmod +x install.sh

# Run the installation
./install.sh
```

The script will:
1. Update your system
2. Install yay (AUR helper)
3. Install all required packages
4. Set up Caelestia shell
5. Configure Hyprland with custom settings
6. Set up Fish shell with AZERTY layout
7. Install LazyVim
8. Configure wallpaper
9. Optionally install apps (Zen, VSCode, Spotify, Discord)

### Post-Installation

After installation, simply type:
```bash
Hyprland
```

Or configure your display manager to start Hyprland.

## ⌨️ Keybindings

| Keybind | Action |
|---------|--------|
| `Super` | Open launcher |
| `Super + T` | Open terminal (Foot) |
| `Super + W` | Open browser (Zen) |
| `Super + C` | Open IDE (VSCode) |
| `Super + Q` | Close window |
| `Super + #` (1-9) | Switch to workspace # |
| `Super + Shift + #` | Move window to workspace # |
| `Super + S` | Toggle special workspace |
| `Super + F` | Toggle fullscreen |
| `Super + V` | Toggle floating |
| `Ctrl + Alt + Delete` | Session menu |
| `Ctrl + Super + Space` | Toggle media play/pause |
| `Ctrl + Super + Alt + R` | Restart Hyprland shell |
| `Super + Shift + S` | Screenshot |

## 🎨 Customization

### Changing the Wallpaper

```bash
# Place your wallpaper in ~/Pictures/
swww img ~/Pictures/your-wallpaper.png

# Make it permanent by adding to ~/.config/hypr/hyprland.conf
echo "exec-once = swww img ~/Pictures/your-wallpaper.png" >> ~/.config/hypr/hyprland.conf
```

### Modifying Keybinds

Edit `~/.config/hypr/hyprland.conf` and look for the `bind =` sections.

### Changing Colors/Theme

The color scheme is managed by Caelestia Shell. To customize:
```bash
# Edit Caelestia theme files
nano ~/.local/share/caelestia-shell/themes/
```

## 🛠️ Configuration Files

```
my-hypr-config/
├── hypr/                 # Hyprland configuration
│   ├── hyprland.conf    # Main config with keybinds
│   └── ...
├── fastfetch/           # Fastfetch config with Arch logo
├── fish/                # Fish shell configuration
│   ├── config.fish
│   └── functions/
├── nvim/                # LazyVim configuration
├── spicetify/           # Starrynight theme
├── foot/                # Terminal configuration
├── btop/                # System monitor theme
├── wallpapers/          # Custom wallpapers
└── starship.toml        # Shell prompt configuration
```

## 📋 Package List

See [PACKAGES.md](PACKAGES.md) for a complete list of installed packages.

## 🐛 Troubleshooting

### Caelestia logo still appears
Make sure you've edited `~/.config/fish/functions/fish_greeting.fish` to use `fastfetch` only.

### Black screen after login
Run `caelestia-shell &` manually, or check if caelestia-shell is installed with `yay -S caelestia-shell`.

### Keyboard not in AZERTY
Check `~/.config/hypr/hyprland.conf` for `kb_layout = fr` in the input section.

### Wallpaper doesn't load
Make sure swww is running: `swww-daemon &` then `swww img ~/Pictures/your-wallpaper.png`

## 🔄 Updating

To update your configuration:

```bash
cd ~/my-hypr-config
git pull
./install.sh
```

## 📝 Credits

- **Base**: [Caelestia](https://github.com/caelestia-dots/caelestia) by soramanew
- **Spotify Theme**: Starrynight
- **Neovim**: [LazyVim](https://github.com/LazyVim/LazyVim) by folke
- **Compositor**: [Hyprland](https://hyprland.org/)

## 🤝 Contributing

Feel free to fork this repo and customize it for your own needs! If you have improvements or fixes, pull requests are welcome.

## 💖 Support

If you like this configuration, consider:
- ⭐ Starring the repo
- 🍴 Forking and customizing it
- 📢 Sharing with others

---

**Made with ❤️ by [Tomy Stark](https://github.com/tomysstark)**

*Enjoy your beautiful Hyprland setup!* ✨
