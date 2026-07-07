{ narbix, ... }:

{
  narbix.hyprlauncher = {
    includes = with narbix; [ hyprland hyprtoolkit desktop ];

    homeManager = { config, ... }:{
      desktop.launcher = config.services.hyprlauncher.package;
      services.hyprlauncher = {
        enable = true;
        settings = {};
      };
    };
  };
}
