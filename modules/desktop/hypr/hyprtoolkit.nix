{ narbix, ... }:

{
  narbix.hyprtoolkit = {
    includes = with narbix; [ hyprland fontScheme ];

    colorSchemePorts = [ "hyprtoolkit" ];
    
    homeManager = { config, lib, ... }:
      let
        size = config.fontScheme.defaultSize;
        h3Size = lib.max (size + 1) (builtins.floor (size * 1.2 + 0.5));
        h2Size = lib.max (h3Size + 1) (builtins.floor (size * 1.4 + 0.5));
        h1Size = lib.max (h2Size + 1) (builtins.floor (size * 1.6 + 0.5));
        smallSize = lib.min (size - 1) (builtins.floor (size * 0.8 + 0.5));
      in
      {
        home.file.".config/hypr/hyprtoolkit.conf" = {
          enable = true;
          text = let size = config.fontScheme.defaultSize; in
            ''
              h1_size = ${builtins.toString h1Size}
              h2_size = ${builtins.toString h2Size}
              h3_size = ${builtins.toString h3Size}
              font_size = ${builtins.toString size}
              small_font_size = ${builtins.toString smallSize}
              font_family = ${config.fontScheme.sansFont.name}
              font_family_monospace = ${config.fontScheme.monoFont.name}
            '';
        };
      };
  };
}
