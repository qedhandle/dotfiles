{ ... }:

{
  narbix.nushell.homeManager = {
    programs.nushell = {
      enable = true;
      settings = {
        show_banner = false;
      };
    };
    # Shell completions
    programs.carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
