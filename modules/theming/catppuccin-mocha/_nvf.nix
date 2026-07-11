palette:

{ inputs, lib, ... }:
let
  inherit (inputs.self.lib) color;
  inherit (lib.generators) mkLuaInline toLua;
  p = palette;
  c = color.srgb.toHex;
  highlights = {
    Normal = { fg = c p.text; bg = c p.base; };
  };
in
{
  programs.nvf.settings.vim = {
    theme.enable = false;
    luaConfigRC = inputs.nvf.lib.nvim.dag.entriesAfter "catppuccin" [ "theme" ]
      (lib.mapAttrsToList
        (name: value:
          mkLuaInline "vim.api.nvim_set_hl(0, ${toLua {} name}, ${toLua {} value})")
        highlights);
  };
}
