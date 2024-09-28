{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware/desktop.nix
      ./modules/impermanence/desktop.nix
      ./modules/common.nix
      # ./modules/i3.nix
      ./modules/steam.nix
      ./modules/xdg.nix
    ];

  environment = {
    pathsToLink = [
      "/share/bash-completion"
    ];
    shells = [
      pkgs.nushell
    ];
    systemPackages = [
      pkgs.cachix
      pkgs.curl
      pkgs.openssl
      pkgs.vim
      pkgs.jq
      pkgs.virt-manager
      pkgs.winetricks
      (pkgs.lutris.override {
        extraPkgs = pkgs: [
          pkgs.wine-staging
        ];
      })
      pkgs.qpwgraph
    ];
  };

  # Wayland stuff
  security.pam.services.swaylock = { }; # allows swaylock check if password is correct
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  security.pam.services.gpu-screen-recorder = { }; # allows swaylock check if password is correct

  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" "armv7l-linux" ];
    initrd = {
      checkJournalingFS = false;
      network = {
        enable = true;
        ssh = {
          enable = true;
          port = 2222;
          hostKeys = [ /persist/system/home/kidsan/other/ssh_host_ed25519_key ];
          authorizedKeys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKas9qjJOceFVG6IS3LgH1RL0EBNZ66LFeLrsOqT31IL kidsan@thinkpad"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPkgNbqSgAdMEx/IaXFsGW6HlobqrsSnl7lanbdfMYaZ JuiceSSH"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMAhyQg3HIZZ+XcpmIEzNkmbMUQwXX2YyjX+RTYAY6cG u0_a191@localhost"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDj31MXtyzN28GceFMNpvXoTioUl3r+aaw4CUQuvAUm/ kidsan@macbookair"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIfLqsgzH8AdYco3e1LbE+gkIIaey/h9QgJevlEC0i67"
          ];
        };
        postCommands = ''
          zpool import -a
          echo "zfs load-key -a; killall zfs" >> /root/.profile
        '';
      };
      kernelModules = [ "r8169" ];
      postDeviceCommands = lib.mkAfter ''
        zfs rollback -r rpool/root/nixos@blank
      '';

    };
    kernel.sysctl."vm.max_map_count" = 2147483642;
    kernelModules = [ "coretemp" "nct6775" "r8169" ];
    loader = {
      grub = {
        # Use the GRUB 2 boot loader.
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        # Define on which hard drive you want to install Grub.
        device = "/dev/nvme0n1"; # or "nodev" for efi only
      };
    };
    supportedFilesystems = [ "zfs" ];
    zfs.devNodes = "/dev/disk/by-partuuid"; # for vm usage
  };

  disko.devices = import ./modules/disko/desktop.nix {
    disks = [ "/dev/nvme0n1" "/dev/sda" "/dev/sdb" ];
  };

  hardware = {
    enableRedistributableFirmware = true;
    graphics.enable = true;
    graphics.extraPackages = [
      pkgs.vulkan-validation-layers

    ];
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      powerManagement.enable = false;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };

  networking.hostId = "e39fd16b";
  networking.hostName = "desktop";
  networking.useDHCP = true;
  networking.interfaces.enp42s0.wakeOnLan = {
    enable = true;
    policy = [ "magic" ];
  };

  programs.dconf.enable = true;

  services = {
    printing.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
    zfs.autoScrub.enable = true;
    zfs.autoSnapshot.enable = true;
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  users = {
    mutableUsers = false;
    users.kidsan = {
      extraGroups = [ "dialout" ];
      shell = pkgs.nushell;
      hashedPasswordFile = "/persist/passwords/kidsan";
    };
  };

  virtualisation.docker.enable = true;
  hardware.nvidia-container-toolkit.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ ];

  virtualisation.oci-containers = {
    backend = "docker";
    containers.isponsorblock = {
      volumes = [ "/etc/sponsorblocktv:/app/data" ];
      image = "ghcr.io/dmunozv04/isponsorblocktv:latest";
      ports = [ ];
      autoStart = true;
      extraOptions = [
        "--net=host"
      ];
    };
  };
}


