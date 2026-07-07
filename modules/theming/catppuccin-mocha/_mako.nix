palette:

{ inputs, ... }:
let
  inherit (inputs.self.lib) color;
  p = palette;
  c = color.srgb.toHex;
in
{
  services.mako.settings = {
    background-color = c p.base;
    text-color = c p.text;
    border-color = c p.overlay0;
    progress-color = c p.sky;
    "urgency=critical" = {
      border-color = c p.red;
      progress-color = c p.peach;
    };
  };
}
