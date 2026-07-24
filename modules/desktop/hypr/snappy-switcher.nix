{ narbix, inputs, ... }:

{
  narbix.snappy-switcher = {
    includes = [ narbix.hyprland ];

    colorSchemePorts = [ "snappy-switcher" ];

    homeManager =
      { pkgs, lib, ... }:
      let
        pkg = inputs.snappy-switcher.packages.${pkgs.system}.default;
        exe = lib.getExe pkg;
      in
      {
        home.packages = [
          inputs.snappy-switcher.packages.${pkgs.system}.default
        ];

        desktop.commands.focusNextWindow = "${exe} next --workspace --mod alt";
        desktop.commands.focusPrevWindow = "${exe} prev --workspace --mod alt";

        desktop.startupApps = [ "${exe} --daemon" ];
      };
  };
}
