{ inputs, ... }:

{
  narbix.nvf = {
    homeManager = {
      imports = [ inputs.nvf.homeManagerModules.default ];

      programs.nvf = {
        enable = true;
        settings.vim = {
          lsp.enable = true;
          languages = {
            nix.enable = true;
            markdown.enable = true;
            json.enable = true;
          };
        };
      };
    };
  };
}
