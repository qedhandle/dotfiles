{ narbix, ... }:

{
  narbix.brightnessctl = {
    includes = [ narbix.desktop ];

    homeManager = { config, pkgs, ... }: {
      home.packages = [ pkgs.brightnessctl ];

      desktop.commands = {
        brightnessUp = "brightnessctl s ${builtins.toString config.desktop.commands.brightnessStep}+%";
        brightnessDown = "brightnessctl s ${builtins.toString config.desktop.commands.brightnessStep}-%";
      };
    };
  };
}
