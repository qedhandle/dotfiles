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
      desktop.commands = {
        volumeUp = "wpctl set-volume @DEFAULT_AUDIO_SINK@ ${builtins.toString config.desktop.commands.volumeStep}%+";
        volumeDown = "wpctl set-volume @DEFAULT_AUDIO_SINK@ ${builtins.toString config.desktop.commands.volumeStep}%-";
        toggleMute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
    };
  };
}
