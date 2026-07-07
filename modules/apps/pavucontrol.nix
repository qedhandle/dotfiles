{ narbix, ... }:

{
  narbix.pavucontrol = {
    includes = with narbix; [
      pipewire
    ];

    homeManager = { pkgs, lib, ... }: {
      home.packages = with pkgs; [
        pavucontrol
      ];
    };
  };
}
