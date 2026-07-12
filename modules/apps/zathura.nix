{ ... }:

{
  narbix.zathura = {
    colorSchemePorts = [ "zathura" ];

    homeManager = { config, ... }: {
      programs.zathura = {
        enable = true;
        options = {
          font =
            let
              family = config.fontScheme.monoFont.name;
              size = builtins.toString config.fontScheme.defaultSize;
            in
            "${family} normal ${size}";
        };
      };
    };
  };
}
