{ narbix, inputs, ... }:

let
  inherit (inputs.self.lib) mkIcon;
in
{
  narbix.waybar.provides.hyprland-workspaces = {
    position ? "right",
    order ? 1000
  }: {
    colorSchemePorts = [ "waybar-hyprland-workspaces" ];

    homeManager = { lib, ... }: {
      programs.waybar = {
        settings.mainBar = {
          "modules-${position}" = lib.mkOrder order [ "hyprland/workspaces" ];
          "hyprland/workspaces" = {
            format = "{icon}${mkIcon "F01DD"}{windows}";
            format-icons = {
              active = mkIcon "EBB4";
              default = mkIcon "EBB5";
            };
            format-window-separator = mkIcon "F01DD";
            workspace-taskbar = {
              enable = true;
              format = "{icon}";
            };
          };
        };
        style = ''
          #workspaces button {
            border-radius: 4px;
            margin: 2px 4px;
          }

          #workspaces label {
            border-radius: 0;
            margin: 0;
            padding: 0;
            background-color: inherit;
            color: inherit;
          }
        '';
      };
    };
  };
}
