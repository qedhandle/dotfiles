{ narbix, inputs, ... }:

{
  narbix.nvf.provides.nerd-signs = {
    includes = [ narbix.nvf ];

    homeManager = {
      programs.nvf.settings.vim.diagnostics.config.signs = {
        text = let inherit (inputs.self.lib) mkIcon; in {
          "vim.diagnostic.severity.ERROR" = mkIcon "EA87";
          "vim.diagnostic.severity.WARN" = mkIcon "EA6C";
          "vim.diagnostic.severity.INFO" = mkIcon "EA74";
          "vim.diagnostic.severity.HINT" = mkIcon "EA61";
        };
      };
    };
  };
}
