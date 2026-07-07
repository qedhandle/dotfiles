{ lib, narbix, ... }:

{
  narbix.fontScheme =
    let
      fontType = {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "The name of the font.";
          };
          package = lib.mkOption {
            type = lib.types.package;
            description = "The package containing the font.";
          };
        };
      };
    in
    {
      homeManager = { config, lib, pkgs, ... }: {
        options.fontScheme = {
          defaultSize = lib.mkOption {
            type = lib.types.int;
            description = "The default size of text (pt).";
            default = 12;
          };
          sansFont = lib.mkOption {
            type = lib.types.submodule fontType;
            description = "The default sans-serif font.";
            default = {
              name = "DejaVu Sans";
              package = pkgs.dejavu_fonts;
            };
          };
          serifFont = lib.mkOption {
            type = lib.types.submodule fontType;
            description = "The default serif font.";
            default = {
              name = "DejaVu Serif";
              package = pkgs.dejavu_fonts;
            };
          };
          monoFont = lib.mkOption {
            type = lib.types.submodule fontType;
            description = "The default monospace font.";
            default = {
              name = "DejaVu Sans Mono";
              package = pkgs.dejavu_fonts;
            };
          };
          emojiFont = lib.mkOption {
            type = lib.types.submodule fontType;
            description = "The default emoji font.";
            default = {
              name = "Noto Color Emoji";
              package = pkgs.noto-fonts-color-emoji;
            };
          };
        };

        config.fonts.fontconfig = {
          enable = true;
          defaultFonts = with config.fontScheme; {
            emoji = lib.mkBefore [ emojiFont.name ];
            monospace = lib.mkBefore [ monoFont.name ];
            sansSerif = lib.mkBefore [ sansFont.name ];
            serif = lib.mkBefore [ serifFont.name ];
          };
        };
      };

    nixos = { host }: { config, lib, ... }: {
      fonts.packages =
        let
          hmUsers =
            builtins.filter
              (user: builtins.elem "homeManager" user.classes)
              (builtins.attrValues host.users);
        in
        builtins.concatMap
          (user:
            let fontConfig = config.home-manager.users.${user.userName}.fontScheme; in
            with fontConfig; [
              sansFont.package
              serifFont.package
              monoFont.package
              emojiFont.package
            ])
          hmUsers;
    };
  };

  den.schema.user.includes = [ narbix.fontScheme ];
}
