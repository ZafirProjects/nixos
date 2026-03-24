{ ... }:

{
  # Allow unfree packages system-wide
  nixpkgs.config.allowUnfree = true;

  # Enable Nix Flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Make home-manager reuse the system nixpkgs instance so that
  # nixpkgs.config settings (e.g. allowUnfree) apply to home.packages too.
  home-manager.useGlobalPkgs = true;
}
