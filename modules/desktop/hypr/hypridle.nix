{ narbix, ... }:

{
  # FIXME: idle not working
  narbix.hypridle = {
    includes = with narbix; [
      desktop
      hyprland
      hyprlock
      brightnessctl
    ];

    homeManager = { config, ... }: {
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "pidof hyprlock || hyprlock";
            before_sleep_cmd = "loginctl lock-session";
            after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
          };
          listener = [
            {
              timeout = 120;
              on-timeout = "brightnessctl -s set 10";
              on-resume = "brightnessctl -r";
            }
            {
              timeout = 300;
              on-timeout = "loginctl lock-session";
            }
            {
              timeout = 305;
              on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'";
              on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })' && brightnessctl -r";
            }
          ];
        };
      };

      desktop.startupApps = [
        config.services.hypridle.package
      ];
    };
  };
}
