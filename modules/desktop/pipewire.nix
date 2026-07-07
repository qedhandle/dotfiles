{ narbix, ... }:

{
  narbix.pipewire = {
    includes = [ narbix.desktop ];

    nixos = {
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };
    };

    homeManager = { config, ... }: {
      desktop = {
        volumeUp = "wpctl set-volume @DEFAULT_AUDIO_SINK@ ${builtins.toString config.desktop.volumeStep}%+";
        volumeDown = "wpctl set-volume @DEFAULT_AUDIO_SINK@ ${builtins.toString config.desktop.volumeStep}%-";
        toggleMute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
    };
  };
}
