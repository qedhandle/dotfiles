{ inputs, ... }:

let
  inherit (inputs.self.lib) mkIcon;
in
{
  narbix.waybar.provides.cpu = {
    position ? "right",
    order ? 1000
  }: {
    homeManager = { lib, ... }: {
      programs.waybar.settings.mainBar = {
        "modules-${position}" = lib.mkOrder order [ "cpu" ];
        cpu = {
          format = "{usage}% ${mkIcon "F4BC"}";
          tooltip = true;
        };
      };
    };
  };
}
