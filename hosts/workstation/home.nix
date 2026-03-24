{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nvf.homeManagerModules.default
    ../../modules/home-manager/packages.nix
    ../../modules/home-manager/nvf.nix
    ../../modules/home-manager/ghostty.nix
  ];

  home.username = "zafir";
  home.homeDirectory = "/home/zafir";

  home.stateVersion = "25.11";

  home.file = {};

  home.sessionVariables = {};

  programs.home-manager.enable = true;
}
