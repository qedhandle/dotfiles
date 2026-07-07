{ ... }:

{
  narbix.firefox = {
    homeManager = { config, ... }: {
      programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
      };
    };
  };
}
