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
      #workspaces button {
        background-color: ${c p.base};
        color: ${c p.text};
      }
    '';
  };
}
