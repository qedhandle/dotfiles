{ ... }:

{
  narbix.nix-output-monitor = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        nix-output-monitor
      ];
    };
  };
}
