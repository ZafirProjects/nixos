{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_6_12;

  # Hostname
  networking.hostName = "nixos";

  # User account
  users.users.zafir = {
    isNormalUser = true;
    description = "Zafir";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Home Manager user binding
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users."zafir" = import ./home.nix;
  };

  system.stateVersion = "25.11";
}
