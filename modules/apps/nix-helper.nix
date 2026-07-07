{ ... }:

{
  narbix.nix-helper = {
    homeManager = { lib, ... }: {
      programs.nh = {
        enable = true;
        clean = {
          enable = true;
          dates = lib.mkDefault "weekly";
          extraArgs = lib.mkDefault "--keep 3 --keep-since 14d";
        };
      };

      home.sessionVariables = {
        NH_ELEVATION_STRATEGY = lib.mkDefault "auto";
      };
    };
  };
}
