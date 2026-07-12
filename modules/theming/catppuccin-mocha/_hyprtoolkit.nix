palette:

{ inputs, ... }:
  let
    inherit (inputs.self.lib) color;
    c = color.srgb.toCSS_RGBA;
    # ca = color.srgb.toCSS_RGBA_withAlpha;
    p = palette;
  in
{
  xdg.configFile."hypr/hyprtoolkit.conf" = {
    enable = true;
    text = ''
      background = ${c p.base}
      base = ${c p.surface0}
      text_color = ${c p.text}
      alternate_base = ${c p.crust}
      bright_text = ${c p.yellow}
      accent = ${c p.lavender}
      accent_secondary = ${c p.teal}
    '';
  };
}
