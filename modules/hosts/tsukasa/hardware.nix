{ den, inputs, ... }:

{
  narbix.tsukasa = {
    includes = [
      (den.batteries.unfree [
        "nvidia-x11"
        "nvidia-settings"
      ])
    ];

    nixos = { config, lib, modulesPath, ... }: {
      imports = [
        "${modulesPath}/installer/scan/not-detected.nix"
      ] ++ (with inputs.nixos-hardware.nixosModules; [
        common-cpu-amd
        common-cpu-amd-raphael-igpu
        common-cpu-amd-pstate
        common-gpu-nvidia
        common-hidpi
        common-pc-laptop
        common-pc-laptop-ssd
        asus-battery
      ]);

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

      boot.kernelParams =
        lib.optionals (lib.versionOlder config.boot.kernelPackages.kernel.version "6.8")
          [ "rtc_cmos.use_acpi_alarm=1" ];
      services.power-profiles-daemon.enable = lib.mkDefault true;
      services.asusd.enable = lib.mkDefault true;
      hardware.nvidia = {
        powerManagement.enable = lib.mkDefault true;
        modesetting.enable = lib.mkDefault true;
        open = lib.mkDefault true;
        nvidiaSettings = lib.mkDefault true;
        prime = {
          amdgpuBusId = "PCI:66@0:0:0";
          nvidiaBusId = "PCI:1@0:0:0";
        };
      };
      hardware.asus.battery.chargeUpto = 80;
    };
  };
}
