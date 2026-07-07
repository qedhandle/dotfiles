{ inputs, narbix, ... }:

{
  narbix.alacritty = {
    includes = with narbix; [
      desktop
      fontScheme
    ];

    homeManager = { config, lib, ... }: {
      programs.alacritty = {
        enable = true;
        settings = {
          font = with config.fontScheme; {
            normal = {
              family = monoFont.name;
              style = "Regular";
            };
            size = defaultSize;
          };
        };
      };

      desktop.terminal = lib.mkDefault config.programs.alacritty.package;
      desktop.terminalExec = lib.mkDefault (cmd: "alacritty -e ${cmd}");
    };

    colorSchemePorts = [ "alacritty" ];
  };
}
