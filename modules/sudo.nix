{ narbix, ... }:

{
  narbix.sudo = {
    nixos = {
      # Disable the one-time warning which is shown every reboot due to impermanence
      security.sudo.extraConfig = ''
        Defaults lecture = never
      '';
    };
  };

  den.default.includes = [
    narbix.sudo
  ];
}
