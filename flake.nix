{

  description = "QED's NixOS configurations.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    den.url = "github:denful/den";
    import-tree.url = "github:denful/import-tree";
    nix-math = {
      url = "github:xddxdd/nix-math";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    (inputs.nixpkgs.lib.evalModules {
      modules = [
        (inputs.import-tree ./modules)
      ];
      specialArgs = { inherit inputs; };
    }).config.flake;

}
