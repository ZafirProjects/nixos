{ pkgs, ... }:

{
  # Display manager
  services.xserver.enable = false;
  services.displayManager.sddm.enable = false;
  services.displayManager.ly.enable = true;

  # Desktop environments / compositors
  services.desktopManager.plasma6.enable = true;
  programs.niri.enable = true;
  programs.mango.enable = true;

  # Install JetBrainsMono Nerd Font system-wide
  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
}
