{ pkgs, config, ... }:

{
  # Write Ghostty config to the user's ~/.config/ghostty/config
  # Replace "zafir" with your username if different
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Horizon";
      font-family = "JetBrainsMono Nerd Font Mono";
      mouse-hide-while-typing = true;
      cursor-invert-fg-bg = true;
      keybind = [
        "super+shift+enter=new_split:auto"
      ];
      background-opacity = 0.9;
    };
  };
}
