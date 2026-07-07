{ narbix, ... }:

{
  narbix.tofi = {
    includes = with narbix; [
      desktop
      fontScheme
    ];

    colorSchemePorts = [ "tofi" ];

    homeManager = { config, lib, ... }: {
      desktop.launcher = "${config.programs.tofi.package}/bin/tofi-drun --drun-launch=true";
      programs.tofi = {
        enable = true;
        settings = {
          font = config.fontScheme.sansFont.name;
          font-size = config.fontScheme.defaultSize;
          outline-width = 0;
          border-width = 2;
          prompt-text = "\"> \"";
          width = "50%";
          height = "50%";
          corner-radius = 4;
        };
      };
    };
  };
}
