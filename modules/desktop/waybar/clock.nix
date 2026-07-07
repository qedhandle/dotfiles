{ inputs, ... }:

let
  inherit (inputs.self.lib) mkIcon;
in
{
  narbix.waybar.provides.clock = {
    position ? "right",
    order ? 1000
  }: {
    homeManager = { lib, ... }: {
      programs.waybar.settings.mainBar = {
        "modules-${position}" = lib.mkOrder order [ "clock" ];
        clock = {
          format = "{:%a %d %b %H:%M} ${mkIcon "F073"}";
          tooltip = true;
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            format = {
              today = "<b><u>{}</u></b>";
            };
          };
        };
      };
    };
  };
}
