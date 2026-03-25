{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Editors
    vim
    neovim
    zed-editor
    obsidian
    onlyoffice-desktopeditors

    # Terminal emulators
    ghostty
    kitty

    # Browser & communication
    vesktop
    element-desktop

    # System tools
    wget
    git

    # Desktop / Wayland utilities
    waybar
    hyprpaper

    # KDE applications
    kdePackages.kate

    # Games
    prismlauncher
    mangohud
    lutris
    heroic
    parsec-bin

    # Audio Video
    audacity
    obs-studio
    handbrake
    vlc
    pinta

    # Proton
    protonmail-desktop
    protonvpn-gui
    proton-pass
  ];
}
