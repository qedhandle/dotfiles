{ ... }:

{
  narbix.desktop = {
    homeManager = { config, lib, ... }: {
      options.desktop = {
        commands = {
          shutdown = lib.mkOption {
            type = lib.types.str;
            description = "The shutdown command.";
            default = "systemctl poweroff";
          };
          reboot = lib.mkOption {
            type = lib.types.str;
            description = "The reboot command.";
            default = "systemctl reboot";
          };
          sleep = lib.mkOption {
            type = lib.types.str;
            description = "The sleep command.";
            default = "systemctl suspend";
          };
          lock = lib.mkOption {
            type = with lib.types; nullOr str;
            description = "The lock command.";
            default = null;
          };
          brightnessUp = lib.mkOption {
            type = with lib.types; nullOr str;
            description = "The command to increase the brightness.";
            default = null;
          };
          brightnessDown = lib.mkOption {
            type = with lib.types; nullOr str;
            description = "The command to decrease the brightness.";
            default = null;
          };
          brightnessStep = lib.mkOption {
            type = lib.types.int;
            description = "The step in the amount of brightness.";
            default = 5;
          };
          volumeUp = lib.mkOption {
            type = with lib.types; nullOr str;
            description = "The command to increase the volume.";
            default = null;
          };
          volumeDown = lib.mkOption {
            type = with lib.types; nullOr str;
            description = "The command to decrease the volume.";
            default = null;
          };
          volumeStep = lib.mkOption {
            type = lib.types.int;
            description = "The step in the amount of volume.";
            default = 2;
          };
          toggleMute = lib.mkOption {
            type = lib.types.str;
            description = "The command to toggle mute.";
            default = null;
          };
        };
        startupApps = lib.mkOption {
          type = with lib.types; listOf (either str package);
          description = "List of startup applications.";
          default = [ ];
        };
        apps =
          let
            appType = with lib.types; nullOr (coercedTo package lib.getExe str);
          in
          {
            audioControl = lib.mkOption {
              type = appType;
              description = "The audio control application.";
              default = null;
            };
            fileExplorer = lib.mkOption {
              type = appType;
              description = "The filex explorer application.";
              default = null;
            };
            launcher = lib.mkOption {
              type = appType;
              description = "The launcher application.";
              default = null;
            };
            terminal = lib.mkOption {
              type = appType;
              description = "The default terminal application.";
              default = null;
            };
          };
        terminalExec = lib.mkOption {
          type = with lib.types; functionTo (nullOr str);
          description = "A map that wraps a command in a newly-spawned terminal.";
          default = _: null;
        };
      };
    };
  };
}
