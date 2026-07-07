# TODO: factor this out into its own aspect somehow
# Probably want to subaspect e.g. NetworkManager, passwd
{ ... }:

{
  narbix.tsukasa = {
    nixos = { config, pkgs, lib, ... }: {
      imports = [
        ./_disko.nix
      ];

      # Rollback "/" on boot
      boot.initrd.systemd.services.rollback-root = {
        description = "Rollback root directory.";
        wantedBy = [ "initrd.target" ];
        after = [
          "initrd-root-device.target"
          "local-fs-pre.target"
        ];
        before = [ "sysroot.mount" ];
        path = with pkgs; [
          coreutils
          util-linux
          btrfs-progs
        ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig = {
          Type = "oneshot";
        };
        script = ''
          mkdir -p /mnt
          mount -o subvol=/ ${config.fileSystems."/".device} /mnt
          btrfs subvolume list -o /mnt/root |
          cut -f9 -d' ' |
          while read subvolume; do
            echo "deleting /$subvolume subvolume..."
            btrfs subvolume delete "/mnt/$subvolume"
          done &&
          echo "deleting /root subvolume..." &&
          btrfs subvolume delete /mnt/root

          echo "restoring blank /root subvolume..."
          btrfs subvolume snapshot /mnt/root-blank /mnt/root

          umount /mnt
        '';
      };

      # Persisted directories
      systemd.tmpfiles.rules = [
        "d /persist/etc 0755 root root - -"
        "d /persist/etc/NetworkManager/system-connections 0700 root root - -"
        "d /persist/var/lib/NetworkManager 0755 root root - -"
        "f /persist/var/lib/NetworkManager/secret_key 0600 root root - -"
        "L /var/lib/NetworkManager/secret_key - - - - /persist/var/lib/NetworkManager/secret_key"
        "f /persist/var/lib/NetworkManager/seen_bssids 0644 root root - -"
        "L /var/lib/NetworkManager/seen_bssids - - - - /persist/var/lib/NetworkManager/seen_bssids"
        "f /persist/var/lib/NetworkManager/timestamps 0644 root root - -"
        "L /var/lib/NetworkManager/timestamps - - - - /persist/var/lib/NetworkManager/timestamps"
      ];

      environment.etc."NetworkManager/system-connections" = {
        enable = true;
        source = "/persist/etc/NetworkManager/system-connections";
      };

      # Persist /etc/shadow
      # https://github.com/nix-community/impermanence/issues/120
      system.activationScripts = {
        etc_shadow = {
          deps = [ "users" ];
          # Sync /etc/shadow and copy on activation (e.g. nixos-rebuild switch)
          # If run during boot, /persist is not mounted so need to check for that
          text = ''
            if [ -d /persist ]; then
              [ -f "/etc/shadow" ] && cp /etc/shadow /persist/etc/shadow
              [ -f "/persist/etc/shadow" ] && cp /persist/etc/shadow /etc/shadow
            fi
          '';
        };
      };
      systemd.services."persist-etc-shadow" = {
        enable = true;
        description = "Persist /etc/shadow on shutdown.";
        wantedBy = [ "multi-user.target" ];
        after = [ "local-fs.target" ];
        path = [ pkgs.util-linux ];
        unitConfig.DefaultDependencies = "yes";
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = pkgs.writeShellScript "restore-shadow"
            ''[ -f "/persist/etc/shadow" ] && cp /persist/etc/shadow /etc/shadow'';
          # Service is stopped before shutdown
          ExecStop = pkgs.writeShellScript "save-shadow" ''
            cp /etc/shadow /persist/etc/shadow
          '';
        };
      };
    };
  };
}
