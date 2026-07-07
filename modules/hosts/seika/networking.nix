{ ... }:

{
  narbix.seika = {
    nixos = {
      networking = {
        interfaces.eth0.ipv4.addresses = [
          {
            address = "192.168.0.10";
            prefixLength = 24;
          }
        ];
        defaultGateway = "192.168.0.1";
        nameservers = [ "1.1.1.1" ];
        useDHCP = false;
      };
    };
  };
}
