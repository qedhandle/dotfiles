{ inputs, ... }:

{
  den.default.includes = [
    { nixos = { imports = [ inputs.disko.nixosModules.disko ]; }; }
  ];
}
