{ inputs, ... }:

let
  inherit (inputs.self.lib) mkIcon;
in
{
  narbix.waybar.provides.network = {
    position ? "right",
    order ? 1000
  }: {
    colorSchemePorts = [ "waybar-network" ];

    homeManager = { lib, ... }: {
      programs.waybar.settings.mainBar = {
        "modules-${position}" = lib.mkOrder order [ "group/network" ];
        "group/network" = {
          orientation = "inherit";
          modules = [ "network#network-group" "network" ];
          drawer = {
            transition-left-to-right = position != "right";
          };
        };
        "network#network-group" = {
          interval = 10;
          format = "{icon}";
          format-disabled = "";
          format-icons = {
            disconnected = [ (mkIcon "F0319") ];
            ethernet = [ (mkIcon "EF09") ];
            wifi = builtins.map mkIcon [
              "F092F"
              "F091F"
              "F0922"
              "F0925"
              "F0928"
            ];
          };
          tooltip = false;
        };
        network = {
          interval = 5;
          format = "{ifname} {bandwidthDownBytes} ${mkIcon "F019"} {bandwidthUpBytes} ${mkIcon "F093"}";
          format-wifi = "{essid} {bandwidthDownBytes} ${mkIcon "F019"} {bandwidthUpBytes} ${mkIcon "F093"}";
          format-disconnected = "Disconnected";
          format-disabled = "";
          tooltip = false;
        };
      };
    };
  };
}
