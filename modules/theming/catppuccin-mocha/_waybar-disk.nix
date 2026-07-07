palette:

{ inputs, ... }:
  let
    inherit (inputs.self.lib) color;
    c = color.srgb.toHex;
    p = palette;
  in
{
  programs.waybar = {
    settings.mainBar.disk = {
      states = {
        full = 80;
      };
    };
    style = ''
      #disk.full {
        color: ${c p.red};
      }
    '';
  };
}
