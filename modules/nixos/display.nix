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

  # Browser
  programs.firefox.enable = true;

  # Printing
  services.printing.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Install JetBrainsMono Nerd Font system-wide
  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
}
