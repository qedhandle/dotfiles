{ den, narbix, lib, ... }:

{
  narbix.test-user = { host, user, ... }: {
    includes =
      (with den.batteries; [
        define-user
        primary-user
      ])
      ++ (with narbix; [
        nushell
        git
        nixvim
        nix-helper
        nix-output-monitor
        nnn
      ] ++ lib.optionals user.graphical [
        desktop
        colorScheme._.catppuccin-mocha
        fontScheme
        hyprland._.basic-dwindle
        hyprlock
        mako
        alacritty
        tofi
        waybar._.basic-bar
        (waybar._.hyprland-workspaces { position = "left"; })
        pipewire
        wiremix
        firefox
      ]);

    nixos = { pkgs, ... }: {
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

    homeManager = { config, pkgs, lib, ... }: {
      # Other per-user configs
    }
    //
    lib.optionalAttrs user.graphical {
      wayland.windowManager.hyprland.settings = lib.mkIf (host.hostName == "seika") {
        monitor = [
          {
            _args = [
              {
                output = "Virtual-1";
                mode = "1920x1080@64";
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
      
      desktop.audioControl =
        lib.mkDefault (config.desktop.terminalExec (lib.getExe pkgs.wiremix));
      desktop.fileExplorer =
        lib.mkDefault (config.desktop.terminalExec (lib.getExe config.programs.nnn.package));
    };
  };
}
