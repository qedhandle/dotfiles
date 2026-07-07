{ den, narbix, ... }:

{
  den.hosts.x86_64-linux.tsukasa = {
    aspect = narbix.tsukasa;
    hostName = "tsukasa";
    users.alice = {
      aspect = narbix.alice;
      userName = "alice";
      displayName = "QED";
      email = "seven2six3one@gmail.com";
    };
  };

  narbix.tsukasa = {
    includes = [ den.provides.hostname ];

    nixos = {
      system.stateVersion = "26.05";

      boot.loader = {
        systemd-boot = {
          enable = true;
          # Dual boot config
          windows."11" = {
            sortKey = "a_windows_11";
            efiDeviceHandle = "HD1b";
          };
        };
        efi.canTouchEfiVariables = true;
        timeout = 30;
      };

      networking.networkmanager.enable = true;

      # Need this or Windows won't use the correct time
      time.hardwareClockInLocalTime = true;

      time.timeZone = "Asia/Singapore";

      i18n.defaultLocale = "en_SG.UTF-8";

      # Set a default password for root so we can enter
      users.users.root.initialPassword = "password";
    };
  };
}
