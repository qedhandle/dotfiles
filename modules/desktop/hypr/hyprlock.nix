{ narbix, ... }:

{
  narbix.hyprlock = {
    includes = with narbix; [ desktop hyprland ];

    colorSchemePorts = [ "hyprlock" ];

    homeManager = { config, lib, ... }: {
      programs.hyprlock = {
        enable = true;
        settings = {
          "$BGCOLOR" = lib.mkDefault "rgba(0, 0, 0, 1.0)";
          "$INPUTBORDERCOLOR" = lib.mkDefault "rgba(255, 255, 255, 1.0)";
          "$INPUTCOLOR" = lib.mkDefault "rgba(255, 255, 255, 1.0)";
          "$INPUTBGCOLOR" = lib.mkDefault "rgba(20, 20, 20, 1.0)";
          "$INPUTCHECKCOLOR" = lib.mkDefault "rgba(0, 255, 255, 1.0)";
          "$INPUTFAILCOLOR" = lib.mkDefault "rgba(255, 0, 0, 1.0)";
          "$INPUTCAPSLOCKCOLOR" = lib.mkDefault "rgba(255, 128, 0, 1.0)";
          "$USERNAMECOLOR" = lib.mkDefault "rgba(255, 255, 255, 1.0)";
          background = [
            {
              path = "screenshot";
              blur_passes = 2;
              # Fallback
              color = "$BGCOLOR";
            }
          ];
          input-field = [
            {
              size = "45%, 10%";
              outer_color = "$INPUTBORDERCOLOR";
              inner_color = "$INPUTBGCOLOR";
              font_color = "$INPUTCOLOR";
              font_family = config.fontScheme.sansFont.name;
              check_color = "$INPUTCHECKCOLOR";
              check_text = "<i>Authenticating...</i>";
              fail_color = "$INPUTFAILCOLOR";
              capslock_color = "$INPUTCAPSLOCKCOLOR";
              position = "0%, -5%";
              fade_on_empty = false;
            }
          ];
          label = [
            {
              text = "$USER";
              color = "$USERNAMECOLOR";
              position = "0%, 20%";
              font_size = config.fontScheme.defaultSize * 5;
            }
          ];
        };
      };

      desktop.lock = "hyprlock";
    };
  };
}
