{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-INTEL_SSDPEKNW010T8_BTNH9331109M1P0B";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "ESP";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            swap = {
              name = "swap";
              size = "16G";
              type = "8200";
              content = {
                type = "swap";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/home" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home";
                  };
                  "/nix" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };
                  "/persist" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/persist";
                  };
                };
                postCreateHook = ''
                  MNTPOINT=$(mktemp -d)
                  mount "/dev/disk/by-partlabel/disk-main-root" "$MNTPOINT" -o subvol=/
                  trap 'umount $MNTPOINT; rm -rf $MNTPOINT' EXIT
                  btrfs subvolume snapshot -r $MNTPOINT/root $MNTPOINT/root-blank
                '';
              };
            };
          };
        };
      };
    };
  };
}
