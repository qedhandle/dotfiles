{ den, narbix, ... }:

{
  den.hosts.x86_64-linux.seika = {
    aspect = narbix.seika;
    hostName = "seika";
    users.user = {
      aspect = narbix.test-user;
      userName = "user";
      displayName = "QED";
      email = "seven2six3one@gmail.com";
    };
  };

  narbix.seika = {
    includes = [ den.provides.hostname ];

    nixos = {
      system.stateVersion = "25.11";

      boot.loader = {
        systemd-boot.enable = true;
        timeout = 30;
      };
    };
  };
}
