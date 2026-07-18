{ narbix, ... }:

{
  narbix.hyprland.provides.basic-dwindle = {
    includes = with narbix; [
      hyprland
      desktop
    ];

    homeManager =
      { config, lib, ... }:
      let
        inherit (lib.generators) mkLuaInline toLua;
        mkLuaStr = s: mkLuaInline (toLua { multiline = false; } s);
        dirKeys = {
          l = "H";
          r = "L";
          u = "K";
          d = "J";
        };
        strOrPkg = value: if builtins.isString value then value else lib.getExe value;
      in
      {
        wayland.windowManager.hyprland.settings = {
          config = {
            general = {
              border_size = 2;
              layout = "dwindle";
            };
            decoration.rounding = 4;
            input.follow_mouse = 2;
            dwindle.force_split = 2;
          };
          bind =
            let
              mkBind =
                {
                  bind,
                  dsp,
                  flags ? null,
                }:
                {
                  _args = [
                    (mkLuaStr bind)
                    (mkLuaInline dsp)
                  ]
                  ++ lib.optional (flags != null) flags;
                };
              mkOptionalBind =
                bind: target:
                lib.optional (target != null) (mkBind {
                  inherit bind;
                  dsp = "hl.dsp.exec_cmd(${toLua { } (strOrPkg target)})";
                });
            in
            [
              (mkBind {
                bind = "CTRL + ALT + W";
                dsp = "hl.dsp.window.close({ window = \"activewindow\" })";
              })
              (mkBind {
                bind = "ALT + Tab";
                dsp = "hl.dsp.window.cycle_next({ next = true })";
              })
              (mkBind {
                bind = "ALT + SHIFT + Tab";
                dsp = "hl.dsp.window.cycle_next({next = false })";
              })
              (mkBind {
                bind = "SUPER + Space";
                dsp = "hl.dsp.window.fullscreen({ mode = \"maximized\", action = \"toggle\" })";
              })
              (mkBind {
                bind = "SUPER + Tab";
                dsp = "hl.dsp.focus({ workspace = \"+1\" })";
              })
              (mkBind {
                bind = "SUPER + SHIFT + Tab";
                dsp = "hl.dsp.focus({ workspace = \"-1\" })";
              })
              (mkBind {
                bind = "SUPER + SHIFT + H";
                dsp = "hl.dsp.window.move({ workspace = \"-1\" })";
              })
              (mkBind {
                bind = "SUPER + SHIFT + L";
                dsp = "hl.dsp.window.move({ workspace = \"+1\" })";
              })
            ]
            ++ lib.mapAttrsToList (
              dir: key:
              mkBind {
                bind = "ALT + ${key}";
                dsp = "hl.dsp.focus({ direction = ${toLua { } dir} })";
              }
            ) dirKeys
            ++ lib.mapAttrsToList (
              dir: key:
              mkBind {
                bind = "SUPER + ${key}";
                dsp = "hl.dsp.window.move({ direction = ${toLua { } dir} })";
              }
            ) dirKeys
            ++ builtins.map (
              i:
              mkBind (
                let
                  wsKey = builtins.toString (lib.mod i 10);
                in
                {
                  bind = "SUPER + ${wsKey}";
                  dsp = "hl.dsp.focus({ workspace = ${builtins.toString i} })";
                }
              )
            ) (lib.range 1 10)
            ++ lib.concatLists (
              lib.mapAttrsToList (name: value: mkOptionalBind name value) {
                "XF86MonBrightnessUp" = config.desktop.commands.brightnessUp;
                "XF86MonBrightnessDown" = config.desktop.commands.brightnessDown;
                "XF86AudioRaiseVolume" = config.desktop.commands.volumeUp;
                "XF86AudioLowerVolume" = config.desktop.commands.volumeDown;
                "XF86AudioMute" = config.desktop.commands.toggleMute;
                "SUPER + T" = config.desktop.apps.terminal;
                "SUPER + R" = config.desktop.apps.launcher;
                "SUPER + E" = config.desktop.apps.fileExplorer;
              }
            );
        };
      };
  };
}
