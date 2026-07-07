palette:

{ inputs, ... }:
let
  inherit (inputs.self.lib) color;
  p = palette;
  c = color.srgb.toHex;
in
{
  programs.tofi.settings = {
    background-color = c p.base;
    border-color = c p.lavender;
    text-color = c p.text;
    prompt-color = c p.subtext1;
    placeholder-color = "${c p.text}80";
    text-cursor-color = c p.rosewater;
    selection-color = c p.red;
  };
}
