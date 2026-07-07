{ narbix, ... }:

{
  narbix.hyprpwcenter = {
    includes = with narbix; [ desktop hyprtoolkit ];

    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.hyprpwcenter ];
      desktop.audioControl = pkgs.hyprpwcenter;
    };
  };
}
