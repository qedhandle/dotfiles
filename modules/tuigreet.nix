{ ... }:

{
  narbix.tuigreet.nixos = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      tuigreet
      bash
    ];
    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --cmd ${pkgs.bash}/bin/bash";
        };
      };
    };
  };
}
