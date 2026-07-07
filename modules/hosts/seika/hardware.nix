{ ... }:

{
  narbix.seika = {
    nixos = { lib, ... }: {
      boot.initrd.availableKernelModules = [ "sd_mod" "sr_mod" ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/eb79b643-639d-4045-bf0b-cdb37bc4ec6d";
        fsType = "ext4";
      };
      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/21CB-5CE1";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };
      swapDevices = [
        { device = "/dev/disk/by-uuid/30898763-6db5-4ac8-ae37-e590221df91c"; }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      virtualisation.hypervGuest.enable = true;
    };
  };
}
