{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware/desktop.nix
      ./modules/impermanence/desktop.nix
      ../lib/cachix.nix
      ./modules/common.nix
      ./modules/kde.nix
      ./modules/steam.nix
    ];

  environment.systemPackages = with pkgs; [
    cachix
    curl
    vim
    virt-manager
  ];

  boot = {
    initrd.checkJournalingFS = false;
    initrd.postDeviceCommands = lib.mkAfter ''
      zfs rollback -r rpool/root/nixos@blank
    '';
    kernelModules = [ "coretemp" "nct6775" ];
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
    opengl.enable = true;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  networking.hostId = "e39fd16b";
  networking.hostName = "desktop";

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
      extraGroups = [ "libvirtd" ];
      hashedPasswordFile = "/persist/passwords/kidsan";
    };
  };

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
}


