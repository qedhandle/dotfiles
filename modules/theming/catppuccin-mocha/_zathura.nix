palette:

{ inputs, lib, ... }:
let
  inherit (inputs.self.lib) color;
  p = palette;
  c = color.srgb.toHex;
in
{
  programs.zathura.options = {
    default-bg = c p.base;
    default-fg = c p.text;
    completion-bg = c p.base;
    completion-fg = c p.text;
    completion-group-bg = c p.base;
    completion-group-fg = c p.text;
    completion-highlight-bg = c p.text;
    completion-highlight-fg = c p.base;
    inputbar-bg = c p.base;
    inputbar-fg = c p.text;
    notification-bg = c p.base;
    notification-fg = c p.text;
    notification-error-bg = c p.base;
    notification-error-fg = c p.red;
    notification-warning-bg = c p.base;
    notification-warning-fg = c p.peach;
    statusbar-bg = c p.surface1;
    statsbar-fg = c p.text;
  };
}
