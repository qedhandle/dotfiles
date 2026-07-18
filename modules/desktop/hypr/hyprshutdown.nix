{ narbix, ... }:

{
  narbix.hyprshutdown = {
    includes = with narbix; [
      desktop
      hyprtoolkit
    ];

    homeManager =
      { pkgs, lib, ... }:
      let
        cmd = lib.getExe pkgs.hyprshutdown;
      in
      {
        home.packages = [ pkgs.hyprshutdown ];
        desktop.commands.shutdown = ''${cmd} -t "Shut down?" -p "systemctl poweroff"'';
        desktop.commands.reboot = ''${cmd} -t "Restart?" -p "systemctl reboot"'';
      };
  };
}
