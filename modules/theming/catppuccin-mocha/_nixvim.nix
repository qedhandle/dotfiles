palette:

{ lib, inputs, ... }:
  let
    inherit (inputs.self.lib) color;
    p = palette;
    c = color.srgb.toHex;
    groups = {
      Normal.fg = c p.text;
      Normal.bg = c p.base;
      Comment.fg = c p.overlay2;
      Comment.italic = true;
      String.fg = c p.green;
      Function.fg = c p.blue;
      Statement.fg = c p.mauve;
      Statement.bold = true;
      Visual.bg = c (color.srgb.over p.overlay2 0.3 p.base);
      Constant.fg = c p.peach;
      Number.fg = c p.peach;
      Operator.fg = c p.sky;
      Delimiter.fg = c p.overlay2;
      CursorLine.bg = c (color.srgb.over p.text 0.1 p.base);
      LineNr.fg = c p.overlay1;
      CursorLineNr.fg = c p.lavender;
      CursorLineNr.bold = true;
      IncSearch.fg = c p.base;
      IncSearch.bg = c p.teal;
      CurSearch.fg = c p.base;
      CurSearch.bg = c p.red;
    };
  in
{
  programs.nixvim.extraConfigLua =
    let
      toLua = lib.generators.toLua {};
    in
    lib.join "\n"
      (lib.mapAttrsToList
        (name: value: "vim.api.nvim_set_hl(0, ${toLua name}, ${toLua value})")
        groups);
}
