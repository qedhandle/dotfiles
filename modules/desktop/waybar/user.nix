{ inputs, ... }:

let
  inherit (inputs.self.lib) mkIcon;
in
{
  narbix.waybar.provides.user = {
    position ? "right",
    order ? 1000
  }: {
    homeManager = { lib, ... }: {
      programs.waybar.settings.mainBar = {
        "modules-${position}" = lib.mkOrder order [ "user" ];
        user = {
          format = "${mkIcon "F007"} <b>{user}</b>";
          open-on-click = false;
        };
      };
    };
  };
}
