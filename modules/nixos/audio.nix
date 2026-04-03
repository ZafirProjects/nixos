{ ... }:

{
  # Disable pulseaudio in favour of pipewire
  services.pulseaudio.enable = false;

  # Enable realtime kit for pipewire
  security.rtkit.enable = true;

  # Enable pipewire with ALSA and PulseAudio compatibility
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    wireplumber.extraConfig = {
      "bluetooth" = {
        "monitor.bluez.properties" = {
          # Disable LDAC - decoder initialization fails with LDACBT_ERR_FATAL
          "bluez5.codecs" = [ "sbc" "sbc_xq" "aac" "aptx" "aptx_hd" ];
        };
      };
    };
  };
}
