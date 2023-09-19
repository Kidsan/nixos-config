{disks,...}:{
    disk = {
      x = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            GRUB = {
              size = "1M";
              type = "EF02";
            };
            ESP = {
              size = "1G";
              type = "EA00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            zfs = {
              end = "-16G";
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
            swap = {
              size = "100%";
              content = {
                type = "swap";
                randomEncryption = true;
                resumeDevice = true;
              };
            };
          };
        };
      };
      y = { 
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            mdadm = {
              size = "100%";
              content = {
                type = "mdraid";
                name = "raid0";
              };
            };
          };
        };
      };
      z = { 
        type = "disk";
        device = "/dev/sdb";
        content = {
          type = "gpt";
          partitions = {
            mdadm = {
              size = "100%";
              content = {
                type = "mdraid";
                name = "raid0";
              };
            };
          };
        };
      };
    };
      mdadm = { 
        "raid0" = {
          type = "mdadm";
          level = 0;
          content = {
            type = "gpt";
            partitions = {
              primary = {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "rpool";
                };
              };
            };
          };
        };
      };
    zpool = {
      rpool = {
        type = "zpool";
        rootFsOptions = {
          compression = "zstd";
        };

        datasets = {
          "root" = {
            type = "zfs_fs";
            options.mountpoint = "none";
            options.encryption = "aes-256-gcm";
            options.keyformat = "passphrase";
            options.keylocation = "file:///tmp/secret.key";
            postCreateHook = ''
              zfs set keylocation="prompt" "rpool/$name";
            '';
          };
          "root/nixos" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/";
            postCreateHook = ''
              zfs snapshot rpool/root/nixos@blank;
            '';
          };
          "root/nix" = {
            mountpoint = "/nix";
            type = "zfs_fs";
            options.mountpoint = "legacy";
          };
          "root/persist" = {
            mountpoint = "/persist";
            type = "zfs_fs";
            options.mountpoint = "legacy";
          };
        };
      };
    };
}

