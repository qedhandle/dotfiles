{ inputs, ... }:

{
  narbix.nvf = {
    colorSchemePorts = [ "nvf" ];

    homeManager = {
      imports = [ inputs.nvf.homeManagerModules.default ];

      programs.nvf = {
        enable = true;
        settings.vim = {
          lsp.enable = true;
          languages = {
            nix.enable = true;
            nix.treesitter.enable = true;
            markdown.enable = true;
            markdown.treesitter.enable = true;
            json.enable = true;
            json.treesitter.enable = true;
          };
          options = {
            autoindent = true;
            cursorline = true;
            expandtab = true;
            number = true;
            relativenumber = true;
            shiftwidth = 2;
            softtabstop = 2;
            wrap = false;
          };
          treesitter.enable = true;
          startPlugins = [
            "rainbow-delimiters-nvim"
          ];
        };
      };
    };
  };
}
