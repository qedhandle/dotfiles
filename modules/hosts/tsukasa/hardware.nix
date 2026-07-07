{ ... }:

{
  narbix.tsukasa = {
    nixos = { config, lib, modulesPath, ... }: {
      imports = [
        "${modulesPath}/installer/scan/not-detected.nix"
      ];

      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "thunderbolt"
        "usbhid"
        "uas"
        "sd_mod"
        "btrfs"
      ];
      boot.kernelModules = [
        "kvm-amd"
      ];

      boot.supportedFilesystems = [ "btrfs" ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  };
}
