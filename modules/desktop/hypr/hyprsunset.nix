{ narbix, ... }:

{
  narbix.hyprsunset = {
    includes = with narbix; [ desktop hyprland ];

    homeManager = { config, ... }: {
      services.hyprsunset = {
        enable = true;
        settings = {
          profile = [
            {
              time = "7:30";
              identity = true;
            }
            {
              time = "21:00";
              temperature = "5000";
            }
          ];
        };
      };

      desktop.startupApps = [ config.services.hyprsunset.package ];
    };
  };
}
