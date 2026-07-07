{ inputs, ... }:

let
  inherit (inputs.self.lib) mkIcon;
in
{
  narbix.waybar.provides.battery = {
    position ? "right",
    order ? 1000
  }: {
    colorSchemePorts = [ "waybar-battery" ];

    homeManager = { lib, ... }: {
      programs.waybar.settings.mainBar = {
        "modules-${position}" = lib.mkOrder order [ "group/battery" ];
        "group/battery" = {
          orientation = "inherit";
          modules = [ "battery#battery-group" "battery" ];
          drawer = {
            transition-left-to-right = position != "right";
          };
        };
        "battery#battery-group" = {
          format = "{icon}";
          format-icons = {
            default = builtins.map mkIcon [
              "F244"
              "F243"
              "F242"
              "F241"
              "F240"
            ];
            charging = [
              (mkIcon "F0E7")
            ];
          };
          tooltip = false;
        };
        battery = {
          format = "{capacity}%";
          tooltip = true;
          tooltip-format = "{timeTo}";
        };
      };
    };
  };
}
