{ narbix, ... }:

{
  narbix.hyprpicker = {
    includes = [ narbix.hyprland ];

    homeManager = { pkgs, lib, ... }: {
      home.packages = with pkgs; [
        hyprpicker
        wl-clipboard
      ];
      wayland.windowManager.hyprland.settings.bind = [
        {
          _args = [
            "SUPER + SHIFT + K"
            (lib.mkLuaInline ''
              hl.dsp.exec_cmd(${lib.generators.toLua {} "${lib.getExe pkgs.hyprpicker} -af hex"})
            '')
          ];
        }
      ];
    };
  };
}
