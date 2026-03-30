{ pkgs, inputs, ... }:
{
  # import the home manager module
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # configure options
  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here
      bar = {
        density = "compact";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          center = [
            {
              formatHorizontal = "ddd MMM d - HH:mm t";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
          right = [
            {
              id = "Tray";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "Network";
            }
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Nord";
      general = {
        avatarImage = "";
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "London, England";
      };
      wallpaper = {
        directory = "~/wallpapers";
        automationEnabled = true;
        randomIntervalSec = 30;
      };
    };
    # this may also be a string or a path to a JSON file.
  };
}
