palette:

{ inputs, lib, ... }:
let
  inherit (inputs.self.lib) color;
  inherit (lib.generators) toLua;
  p = palette;
  c = color.srgb.toHex;
  highlights = {
    Normal = { fg = c p.text; bg = c p.base; };
    NonText = { fg = c p.subtext0; };
    StatusLine = { fg = c p.text; bg = c p.surface1; };
    StatusLineNC = { fg = c p.text; bg = c p.surface0; };
    Cursor = { fg = c p.base; bg = c p.rosewater; };
    CursorLine = { bg = c (color.srgb.over p.text 0.1 p.base); };
    LineNr = { fg = c p.mauve; bg = c p.mantle; bold = true; };
    LineNrAbove = { fg = c p.subtext0; bg = c p.mantle; };
    LineNrBelow = { fg = c p.subtext0; bg = c p.mantle; };
    SignColumn = { bg = c p.mantle; };
    FoldColumn = { bg = c p.mantle; };
    Visual = { bg = c (color.srgb.over p.overlay2 0.2 p.base); };
    CurSearch = { bg = c p.red; };
    Search = { bg = c p.teal; };

    DiagnosticError = { fg = c p.red; };
    DiagnosticWarn = { fg = c p.peach; };
    DiagnosticHint = { fg = c p.yellow; };
    DiagnosticInfo = { fg = c p.teal; };

    Comment = { fg = c p.overlay2; italic = true; };
    Constant = { fg = c p.peach; };
    Number = { fg = c p.peach; };
    Float = { fg = c p.peach; };
    String = { fg = c p.green; };
    Character = { fg = c p.green; };
    Boolean = { fg = c p.teal; };
    Identifier = { fg = c p.text; };
    Function = { fg = c p.blue; };
    Keyword = { fg = c p.mauve; };
    Special = { fg = c p.pink; };
    Statement = { fg = c p.mauve; };
    Operator = { fg = c p.sky; };

    Todo = { fg = c p.teal; bold = true; };
    Underlined = { fg = c p.blue; };

    RainbowDelimiterRed = { fg = c p.red; };
    RainbowDelimiterOrange = { fg = c p.peach; };
    RainbowDelimiterYellow = { fg = c p.yellow; };
    RainbowDelimiterGreen = { fg = c p.green; };
    RainbowDelimiterBlue = { fg = c p.sapphire; };
    RainbowDelimiterViolet = { fg = c p.lavender; };
  };
in
{
  programs.nvf.settings.vim = {
    theme.enable = false;
    luaConfigRC = inputs.nvf.lib.nvim.dag.entriesAfter "catppuccin" [ "theme" ]
      (lib.mapAttrsToList
        (name: value:
          "vim.api.nvim_set_hl(0, ${toLua {} name}, ${toLua { multiline = false; } value})")
        highlights);
    globals.rainbow_delimiters = {
      highlight = [
        "RainbowDelimiterRed"
        "RainbowDelimiterOrange"
        "RainbowDelimiterYellow"
        "RainbowDelimiterGreen"
        "RainbowDelimiterBlue"
        "RainbowDelimiterViolet"
      ];
    };
  };
}
