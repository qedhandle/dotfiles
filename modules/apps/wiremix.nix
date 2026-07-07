{ narbix, ... }:

{
  narbix.wiremix = {
    includes = [ narbix.desktop ];

    homeManager = { config, pkgs, lib, ... }: {
      home.packages = with pkgs; [
        wiremix
      ];
    };

    # TODO: there's some cool theming possibilities here.
  };
}
