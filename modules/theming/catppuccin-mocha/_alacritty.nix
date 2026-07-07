palette:

{ lib, inputs, ... }:
let
  inherit (inputs.self.lib) color;
  p = palette;
  c = color.srgb.toHex;
  compose = fs:
    lib.foldr (h: t: x: h (t x)) lib.id fs;
  lighten = compose [
    color.ciexyz.toSRGB
    color.cielab.toCIEXYZ
    color.cielch.toCIELAB
    ({ l, c, h }: { l = l * 0.94; c = c + 8; h = h + 2; })
    color.cielab.toCIELCH
    color.ciexyz.toCIELAB
    color.srgb.toCIEXYZ
  ];
in
{
  programs.alacritty.settings.colors = {
    primary.foreground = c p.text;
    primary.background = c p.base;
    cursor.text = c p.crust;
    cursor.cursor = c p.rosewater;
    vi_mode_cursor.text = c p.crust;
    vi_mode_cursor.cursor = c p.rosewater;
    search.matches.foreground = c p.base;
    search.matches.background = c p.teal;
    search.focused_match.foreground = c p.base;
    search.focused_match.background = c p.red;
    hints.start.foreground = c p.base;
    hints.start.background = c p.yellow;
    hints.end.foreground = c p.blue;
    hints.end.background = c p.subtext0;
    footer_bar.foreground = c p.text;
    footer_bar.background = c p.surface2;
    selection.text = c p.text;
    selection.background = c (color.srgb.over p.overlay2 0.3 p.base);
    normal.black = c p.surface1;
    normal.red = c p.red;
    normal.green = c p.green;
    normal.yellow = c p.yellow;
    normal.blue = c p.blue;
    normal.magenta = c p.pink;
    normal.cyan = c p.teal;
    normal.white = c p.subtext0;
    bright.black = c p.surface2;
    bright.red = c (lighten p.red);
    bright.green = c (lighten p.green);
    bright.yellow = c (lighten p.yellow);
    bright.blue = c (lighten p.blue);
    bright.magenta = c (lighten p.pink);
    bright.cyan = c (lighten p.teal);
    bright.white = c p.subtext1;
    indexed_colors = [
      { index = 16; color = c p.peach; }
      { index = 17; color = c p.rosewater; }
    ];
  };
}
