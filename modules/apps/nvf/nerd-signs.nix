{ narbix, inputs, ... }:

{
  narbix.nvf.provides.nerd-signs = {
    includes = [ narbix.nvf ];

    homeManager = { lib, ... }: {
      programs.nvf.settings.vim.diagnostics = {
        enable = true;
        config.signs.text =
          let
            inherit (inputs.self.lib) mkIcon;
            icon = code: lib.generators.toLua {} (mkIcon code + " ");
          in
        lib.mkLuaInline ''
          {
            [vim.diagnostic.severity.ERROR] = ${icon "F2D3"},
            [vim.diagnostic.severity.WARN] = ${icon "F071"},
            [vim.diagnostic.severity.INFO] = ${icon "F06A"},
            [vim.diagnostic.severity.HINT] = ${icon "F0EB"},
          }
        '';
      };
    };
  };
}
