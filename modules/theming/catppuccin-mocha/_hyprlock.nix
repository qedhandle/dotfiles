palette:

{ inputs, ... }:
  let
    inherit (inputs.self.lib) color;
    c = color.srgb.toCSS_RGBA;
    p = palette;
    t = col: color.srgb.toCSS_RGBA_withAlpha { color = col; alpha = 0.3; };
  in
{
  programs.hyprlock.settings = {
    "$BGCOLOR" = c p.base;
    "$INPUTBORDERCOLOR" = t p.overlay0;
    "$INPUTCOLOR" = c p.text;
    "$INPUTBGCOLOR" = t p.overlay2;
    "$INPUTCHECKCOLOR" = t p.lavender;
    "$INPUTFAILCOLOR" = t p.red;
    "$INPUTCAPSLOCKCOLOR" = t p.peach;
    "$USERNAMECOLOR" = c p.text;
  };
}
