{ narbix, ... }:

{
  narbix.waybar = {
    includes = with narbix; [
      desktop
      fontScheme
    ];

    colorSchemePorts = [ "waybar" ];

    homeManager = { config, lib, ... }:
      let
        groups = lib.concatMap
          (name:
            if lib.hasPrefix "group/" name then
              [ (lib.removePrefix "group/" name) ]
            else
              [])
          (builtins.attrNames config.programs.waybar.settings.mainBar);
      in
    {
      programs.waybar = {
        enable = true;
        style = ''
          * {
            font-family: "${config.fontScheme.sansFont.name}", sans-serif;
            font-size: ${builtins.toString config.fontScheme.defaultSize}pt;
            border: none;
            min-height: 0;
          }

          label {
            padding: 4px;
            border-radius: 4px;
            margin: 2px 4px;
          }
        ''
        +
        lib.join "\n"
          (builtins.map
            (name: ''
              #${name} {
                border-radius: 4px;
                margin: 2px 4px;
                padding: 4px;
              }

              #${name} label {
                border-radius: 0;
                margin: 0 2px;
                padding: 0;
                background-color: transparent;
              }
            '')
            groups);
      };

      desktop.startupApps = [
        config.programs.waybar.package
      ];
    };
  };
}
