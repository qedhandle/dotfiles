palette:

{ inputs, ... }:
  let
    inherit (inputs.self.lib) color;
    c = color.srgb.toHex;
    p = palette;
  in
{
  home.file.".config/hypr/hyprtoolkit.conf" = {
    text = ''
      background = "${c p.base};
      base = ${c p.crust};
      text_color = ${c p.text};
      alternate_base = ${c p.crust};
      bright_text = ${c p.yellow};
      accent = ${c p.red};
      accent_secondary = ${c p.peach};
    '';
  };
}
