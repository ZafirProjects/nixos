{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  programs.obs-studio = {
    enable = true;
    package = (pkgs.obs-studio.override {
            cudaSupport = true;
        });
  };
}
