{ narbix, ... }:

{
  narbix.hyprland = {
    includes = [ narbix.colorScheme ];

    nixos = {
      programs.hyprland.enable = true;
    };

    colorSchemePorts = [ "hyprland" ];

    homeManager = { keybinds, config, pkgs, lib, ... }: {
      home.sessionVariables = {
        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "Hyprland";
      };

      home.packages = with pkgs; [
        # xdg-desktop-portal-hyprland does not have a file chooser
        xdg-desktop-portal-gtk
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";
        settings = {
          on =
            let
              strOrPackage = value:
                if builtins.isString value then
                  value
                else
                  lib.getExe value;
            in
            builtins.map
              (app: {
                _args = [
                  "hyprland.start"
                  (lib.generators.mkLuaInline
                    ''
                    function()
                      hl.exec_cmd("${strOrPackage app}")
                    end
                    '')
                ];
              })
              config.desktop.startupApps;
        };
      };

      warnings =
        let
          settings = config.wayland.windowManager.hyprland.settings;
        in
        lib.mkIf (!(settings ? monitor) || settings.monitor == [])
          [ "No monitors configured for hyprland." ];
    };
  };
}
