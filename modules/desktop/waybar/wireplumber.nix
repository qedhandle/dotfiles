{ narbix, inputs, ... }:

let
  inherit (inputs.self.lib) mkIcon;
in
{
  narbix.waybar.provides.wireplumber = {
    position ? "right",
    order ? 1000
  }: {
    includes = with narbix; [ desktop pipewire ];

    homeManager = { config, lib, ... }: {
      programs.waybar.settings.mainBar = {
        "modules-${position}" = lib.mkOrder order [ "wireplumber" ];
        wireplumber = {
          format = "{icon}";
          format-muted = mkIcon "EEE8";
          format-icons = builtins.map mkIcon [
            "F026"
            "F027"
            "F028"
          ];
          tooltip = true;
          tooltip-format = "{volume}%";
          on-click-right = config.desktop.toggleMute;
          on-scroll-up = config.desktop.volumeUp;
          on-scroll-down = config.desktop.volumeDown;
        }
        //
        lib.optionalAttrs (config.desktop.audioControl != null)
          {
            on-click =
              if builtins.isString config.desktop.audioControl then
                config.desktop.audioControl
              else
                lib.getExe config.desktop.audioControl;
          };
      };
    };
  };
}
