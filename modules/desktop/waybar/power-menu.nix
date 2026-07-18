{ narbix, inputs, ... }:

let
  inherit (inputs.self.lib) mkIcon;
in
{
  narbix.waybar.provides.power-menu =
    {
      position ? "right",
      order ? 1000,
    }:
    {
      includes = [ narbix.desktop ];

      colorSchemePorts = [ "waybar-powermenu" ];

      homeManager =
        { config, lib, ... }:
        let
          shutdown = {
            name = "shutdown";
            value = {
              format = mkIcon "F011";
              on-click = config.desktop.commands.shutdown;
              tooltip = true;
              tooltip-format = "Shutdown";
            };
          };
          reboot = {
            name = "reboot";
            value = {
              format = mkIcon "F021";
              on-click = config.desktop.commands.reboot;
              tooltip = true;
              tooltip-format = "Reboot";
            };
          };
          sleep = {
            name = "sleep";
            value = {
              format = mkIcon "F186";
              on-click = config.desktop.commands.sleep;
              tooltip = true;
              tooltip-format = "Sleep";
            };
          };
          lock = lib.optional (config.desktop.commands.lock != null) {
            name = "lock";
            value = {
              format = mkIcon "F023";
              on-click = config.desktop.commands.lock;
              tooltip = true;
              tooltip-format = "Lock";
            };
          };
          items =
            if position == "right" then
              # This weird ordering is necessary to keep the lock button furthest away.
              [ shutdown ]
              ++ lock
              ++ [
                sleep
                reboot
              ]
            else
              [
                shutdown
                reboot
                sleep
              ]
              ++ lock;
        in
        {
          programs.waybar = {
            settings.mainBar = {
              "modules-${position}" = lib.mkOrder order [ "group/power" ];
              "group/power" = {
                orientation = "inherit";
                modules = builtins.map (item: "custom/power-${item.name}") items;
                drawer = {
                  transition-left-to-right = position != "right";
                };
              };
            }
            // lib.listToAttrs (builtins.map (item: item // { name = "custom/power-${item.name}"; }) items);
          };
        };
    };
}
