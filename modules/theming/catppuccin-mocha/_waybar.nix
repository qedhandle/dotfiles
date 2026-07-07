palette:

{ inputs, config, lib, ... }:
  let
    inherit (inputs.self.lib) color;
    c = color.srgb.toHex;
    p = palette;
    groups = lib.concatMap
      (name:
        if lib.hasPrefix "group/" name then
          [ (lib.removePrefix "group/" name) ]
        else
          [])
      (builtins.attrNames config.programs.waybar.settings.mainBar);
  in
{
  programs.waybar.style = ''
    window#waybar {
      background-color: alpha(${c p.overlay2}, 0.4);
    }

    label {
      background-color: ${c p.base};
      color: ${c p.text};
    }

    tooltip {
      background-color: alpha(${c p.base}, 0.8);
      border-color: ${c p.overlay0};
      color: ${c p.text};
    }
  ''
  +
  lib.join "\n"
    (builtins.map
      (name: ''
        #${name} {
          background-color: ${c p.base};
        }
      '')
      groups);
}
