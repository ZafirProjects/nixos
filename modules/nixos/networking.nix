{ ... }:

{
  # Bluetooth
  hardware.bluetooth.enable = true;

  # Enable NetworkManager for wireless and wired networking
  networking.networkmanager.enable = true;

  # Hostname
  networking.hostName = "default";

  # Printing
  services.printing.enable = true;
}
