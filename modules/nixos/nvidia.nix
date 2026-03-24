{ config, ... }:

{
  # OpenGL
  hardware.graphics.enable = true;

  # Nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Required for wayland + nvidia
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
}
