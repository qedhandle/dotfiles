{ narbix, ... }:

{
  narbix.brightnessctl = {
    includes = [ narbix.desktop ];

    homeManager = { config, pkgs, ... }: {
      home.packages = [ pkgs.brightnessctl ];

      desktop = {
        brightnessUp = "brightnessctl s ${builtins.toString config.desktop.brightnessStep}+%";
        brightnessDown = "brightnessctl s ${builtins.toString config.desktop.brightnessStep}-%";
      };
    };
  };
}
