{ pkgs, inputs, ... }:

{
  # Browser
  programs.firefox.enable = true;

  #Shell
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    # System tools
    wget
    git
    grim
    slurp
    wl-clipboard
    xdg-desktop-portal-wlr
    fzf
    zoxide
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    prettierd
    stylua
  ];
}
