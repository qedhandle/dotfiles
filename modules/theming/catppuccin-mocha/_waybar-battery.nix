palette:

{ inputs, ... }:
  let
    inherit (inputs.self.lib) color;
    c = color.srgb.toHex;
    p = palette;

    states = {
      medium = 50;
      low = 30;
      critical = 15;
    };
  in
{
  programs.waybar = {
    settings.mainBar.battery = {
      inherit states;
    };
    settings.mainBar."battery#battery-group" = {
      inherit states;
    };
    style = ''
      #battery {
        background-color: ${c p.base};
        color: ${c p.green};
      }

      #battery.medium {
        color: ${c p.yellow};
      }

      #battery.low {
        color: ${c p.peach};
      }

      #battery.critical {
        color: ${c p.red};
      }
    '';
  };
}
