{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nvf.homeManagerModules.default
    inputs.mango.hmModules.mango
    ../../modules/home-manager/packages.nix
    ../../modules/home-manager/nvf.nix
    ../../modules/home-manager/ghostty.nix
    ../../modules/home-manager/mango.nix
    ../../modules/home-manager/noctalia.nix
  ];

  home.username = "zafir";
  home.homeDirectory = "/home/zafir";

  home.stateVersion = "25.11";

  home.file = {
    ".zshrc" = {
      source = ../../modules/home-manager/zshrc;
    };
  };

  home.sessionVariables = {};

  programs.home-manager.enable = true;
}
