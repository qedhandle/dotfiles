{ inputs, ... }:

{
  narbix.nixvim = {
    colorSchemePorts = [ "nixvim" ];

    homeManager = { config, pkgs, ... }: {
      imports = [ inputs.nixvim.homeModules.nixvim ];

      programs.nixvim = {
        enable = true;
        opts = {
          autoindent = true;
          cursorline = true;
          expandtab = true;
          number = true;
          relativenumber = true;
          scrolloff = 999;
          shiftwidth = 2;
          softtabstop = 2;
        };
        # plugins.telescope.enable = true;
        plugins.treesitter = {
          enable = true;
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            c
            cpp
            json
            lua
            make
            markdown
            nix
            python
            regex
            rust
            toml
            vim
            xml
          ];
        };
      };
    };
  };
}
