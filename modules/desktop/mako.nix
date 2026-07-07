{ narbix, ... }:

{
  narbix.mako = {
    includes = with narbix; [
      fontScheme
    ];

    colorSchemePorts = [ "mako" ];

    homeManager = { config, pkgs, lib, ... }: {
      services.mako = {
        enable = true;
        settings = {
          font =
            let
              fs = config.fontScheme;
            in
            "\"${fs.sansFont.name}\" ${builtins.toString fs.defaultSize}";
          border-size = lib.mkDefault 2;
          border-radius = lib.mkDefault 4;
          icon-location = lib.mkDefault "left";
          default-timeout = lib.mkDefault 10000;
          anchor = lib.mkDefault "top-right";
        };
      };

      home.packages = with pkgs; [
        libnotify
      ];
    };
  };
}
