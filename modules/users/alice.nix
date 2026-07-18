{
  den,
  narbix,
  lib,
  ...
}:

{
  narbix.alice = { host, user, ... }: {
    includes =
      (with den.batteries; [
        define-user
        primary-user
      ])
      ++ (
        with narbix;
        [
          nushell
          git
          nvf
          nvf._.nerd-signs
          nix-helper
          nix-output-monitor
          nnn
          fastfetch
          direnv
          direnv._.nushell
        ]
        ++ lib.optionals user.graphical [
          mepad
          colorScheme._.catppuccin-mocha
          wiremix
          firefox
          zathura # PDF viewer
        ]
      );

    nixos = { user, ... }: { pkgs, ... }: {
      users.users.${user.userName}.shell = pkgs.nushell;

      environment.systemPackages = with pkgs; [
        tuigreet
      ];

      services.greetd = {
        enable = true;
        settings.default_session = {
          command = "tuigreet --asterisks -c start-hyprland";
        };
      };
    };

    homeManager =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        # Other per-user configs
        # TODO: factor into a "developer" aspect
        programs.nvf.settings.vim.languages = {
          clang.enable = true;
          rust.enable = true;
          typst.enable = true;
        };
      }
      // lib.optionalAttrs user.graphical {
        desktop = {
          # Launch on current workspace
          apps.audioControl =
            let
              cmd = config.desktop.terminalExec (lib.getExe pkgs.wiremix);
            in
            "hyprctl dispatch ${lib.escapeShellArg "hl.dsp.exec_cmd(${lib.generators.toLua { } cmd})"}";
          apps.fileExplorer = config.desktop.terminalExec (lib.getExe config.programs.nnn.package);
        };

        wayland.windowManager.hyprland.settings = {
          # TODO: this should be specific to the host
          monitor = [
            {
              _args = [
                {
                  output = "desc:China Star Optoelectronics Technology Co. Ltd MNG007DA5-3";
                  mode = "2560x1600@165";
                  position = "0x0";
                  scale = 1;
                }
              ];
            }
          ];
        };

        fontScheme = {
          defaultSize = 12;
          serifFont = {
            name = "NotoSerif Nerd Font";
            package = pkgs.nerd-fonts.noto;
          };
          sansFont = {
            name = "NotoSans Nerd Font";
            package = pkgs.nerd-fonts.noto;
          };
          monoFont = {
            name = "NotoSansM Nerd Font";
            package = pkgs.nerd-fonts.noto;
          };
        };
      };
  };
}
