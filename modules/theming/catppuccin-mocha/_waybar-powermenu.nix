palette:

{ inputs, ... }:
  let
    inherit (inputs.self.lib) color;
    c = color.srgb.toHex;
    p = palette;
  in
{
  programs.waybar = {
    style = ''
      label#custom-power-shutdown {
        color: ${c p.red};
      }

      label#custom-power-reboot {
        color: ${c p.yellow};
      }

      label#custom-power-sleep {
        color: ${c p.blue};
      }

      label#custom-power-lock {
        color: ${c p.subtext0};
      }
    '';
  };
}
