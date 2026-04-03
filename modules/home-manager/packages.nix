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

    # Games
    prismlauncher
    lutris
    heroic
    parsec-bin

    # Audio Video
    audacity
    handbrake
    vlc
    pinta

    # Proton
    protonmail-desktop
    proton-vpn
    proton-pass
  ];
}
