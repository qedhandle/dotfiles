{ inputs, ... }:

let
  inherit (inputs.self.lib) mkIcon;
in
{
  narbix.waybar.provides.memory = {
    position ? "right",
    order ? 1000
  }: {
    homeManager = { lib, ... }: {
      programs.waybar.settings.mainBar = {
        "modules-${position}" = lib.mkOrder order [ "memory" ];
        memory = {
          format = "{percentage}% ${mkIcon "EFC5"}";
          tooltip = true;
          tooltip-format = "{used:0.1f}GiB/{total:0.1f}GiB";
        };
      };
    };
  };
}
