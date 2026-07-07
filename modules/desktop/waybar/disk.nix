{ inputs, ... }:

let
  inherit (inputs.self.lib) mkIcon;
in
{
  narbix.waybar.provides.disk = {
    position ? "right",
    order ? 1000
  }: {
    colorSchemePorts = [ "waybar-disk" ];

    homeManager = { lib, ... }: {
      programs.waybar.settings.mainBar = {
        "modules-${position}" = lib.mkOrder order [ "disk" ];
        disk = {
          format = "{used} ${mkIcon "F0A0"}";
          tooltip = true;
          tooltip-format = "out of {total}";
        };
      };
    };
  };
}
