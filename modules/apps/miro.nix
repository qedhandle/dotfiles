# Seems to be broken :<
# Uses rfd crate which uses dlopen to search for libdbus
{ ... }:

{
  narbix.miro = {
    homeManager = { config, pkgs, lib, ... }: {
      options.programs.miro = {
        config = {
          binds = lib.mkOption {
            type = with lib.types; attrsOf str;
            description = "List of key bindings.";
            example = lib.literalExpression ''
              { j = "MoveDown"; }
            '';
            default = {};
          };
          mouseBinds = lib.mkOption {
            type = with lib.types; attrsOf str;
            description = "List of mouse bindings.";
            example = lib.literalExpression ''
              { MouseLeft = "Panning"; }
            '';
            default = {};
          };
          settings = lib.mkOption {
            type = with lib.types; attrsOf str;
            description = "List of settings.";
            default = {};
          };
        };
      };
      config = let cfg = config.programs.miro; in {
        home.packages = [ pkgs.miro ];
        home.file.".config/miro-pdf/miro.conf" = {
          enable = true;
          text =
            let
              bindsText = lib.join "\n"
                (lib.mapAttrsToList
                  (name: value:
                    ''Bind "${name}" ${value}'')
                  cfg.config.binds);
              mouseBindsText = lib.join "\n"
                (lib.mapAttrsToList
                  (name: value:
                    ''MouseBind "${name}" ${value}'')
                  cfg.config.binds);
              settingsText = lib.join "\n"
                (lib.mapAttrsToList
                  (name: value:
                    ''Set ${name} ${value}'')
                  cfg.config.binds);
            in
            "# Binds\n"
            + bindsText
            + "\n\n# Mouse Binds\n"
            + mouseBindsText
            + "\n\n# Settings\n"
            + settingsText;
        };
        xdg.desktopEntries.miro = {
          name = "miro";
          type = "Application";
          exec = lib.getExe pkgs.miro;
          categories = [ "Office" ];
        };
      };
    };
  };
}
