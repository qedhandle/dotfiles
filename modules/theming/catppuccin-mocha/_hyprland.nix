palette:

{ inputs, ... }:
let
  inherit (inputs.self.lib) color;
  p = palette;
  c = color.srgb.toHex;
in
{
  wayland.windowManager.hyprland.settings = {
    config.general.col = {
      active_border = c p.lavender;
      inactive_border = c p.overlay0;
    };
  };
}
