{ ... }:

{
  narbix.direnv = {
    homeManager = { config, ... }: {
      programs.direnv = {
        enable = true;
      };
    };
  };

  narbix.direnv.provides = {
    bash.homeManager.programs.direnv.enableBashIntegration = true;
    fish.homeManager.programs.direnv.enableFishIntegration = true;
    nushell.homeManager.programs.direnv.enableNushellIntegration = true;
    zsh.homeManager.programs.direnv.enableZshIntegration = true;
  };
}
