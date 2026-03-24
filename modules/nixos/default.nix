{ ... }:

{
  imports = [
    ./nix.nix
    ./nvidia.nix
    ./display.nix
    ./audio.nix
    ./locale.nix
    ./networking.nix
    ./gaming.nix
    ./packages.nix
  ];
}
