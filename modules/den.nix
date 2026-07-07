{ den, inputs, lib, ... }:

{
  imports = [ inputs.den.flakeModule ];

  # Configure home-manager for all users
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  den.default.includes = with den.batteries; [
    define-user
    {
      homeManager = {
        # Add inputs as a top-level argument to home-manager modules.
        _module.args = { inherit inputs; };
      };
    }
  ];
  den.default.nixos = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  den.default.homeManager.home.stateVersion = lib.mkDefault "25.11";
}
