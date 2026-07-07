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
      #network {
        background-color: ${c p.base};
        color: ${c p.blue};
      }

      #network.disconnected {
        background-color: ${c p.base};
        color: ${c p.subtext0};
      }
    '';
  };
}
