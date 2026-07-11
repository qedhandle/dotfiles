{ inputs, ... }:

let
  inherit (inputs.self.lib.color.srgb) fromHex;
  palette = {
    rosewater = fromHex "#f5e0dc";
    flamingo = fromHex "#f2cdcd";
    pink = fromHex "#f5c2e7";
    mauve = fromHex "#cba6f7";
    red = fromHex "#f38ba8";
    maroon = fromHex "#eba0ac";
    peach = fromHex "#fab387";
    yellow = fromHex "#f9e2af";
    green = fromHex "#a6e3a1";
    teal = fromHex "#94e2d5";
    sky = fromHex "#89dceb";
    sapphire = fromHex "#74c7ec";
    blue = fromHex "#89b4fa";
    lavender = fromHex "#b4befe";
    text = fromHex "#cdd6f4";
    subtext1 = fromHex "#bac2de";
    subtext0 = fromHex "#a6adc8";
    overlay2 = fromHex "#9399b2";
    overlay1 = fromHex "#7f849c";
    overlay0 = fromHex "#6c7086";
    surface2 = fromHex "#585b70";
    surface1 = fromHex "#45475a";
    surface0 = fromHex "#313244";
    base = fromHex "#1e1e2e";
    mantle = fromHex "#181825";
    crust = fromHex "#11111b";
  };
in
{
  narbix.colorScheme.provides.catppuccin-mocha = {
    homeManager = { colorSchemePorts, ... }:
      let
        hasPort = name: builtins.pathExists ./_${name}.nix;
        validPorts = builtins.filter hasPort colorSchemePorts;
        portModules = builtins.map (name: import ./_${name}.nix palette) validPorts;
        warnings =
          builtins.map
            (name: "Catppuccin-mocha port for ${name} has not been implemented.")
            (builtins.filter (name: !(hasPort name)) colorSchemePorts);
      in
      {
        imports = portModules;
        config.warnings = warnings;
      };
  };
}
