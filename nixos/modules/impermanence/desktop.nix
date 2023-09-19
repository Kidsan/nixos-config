# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, disko, impermanence,  ... }:
{
disko.devices = import ../disko/desktop.nix {
disks = [ "/dev/nvme0n1" "/dev/sda" "/dev/sdb"];
};

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;

   boot.loader.grub.efiSupport = true;
   boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
   boot.loader.grub.device = "/dev/nvme0n1"; # or "nodev" for efi only
   boot.supportedFilesystems = [ "zfs" ];
   boot.initrd.checkJournalingFS = false;

networking.hostId = "e39fd16b";
services.zfs.autoSnapshot.enable = true;
services.zfs.autoScrub.enable = true;

boot.initrd.postDeviceCommands = lib.mkAfter ''
  zfs rollback -r rpool/root/nixos@blank
'';

boot.zfs.devNodes = "/dev/disk/by-partuuid"; # for vm usage only

environment.persistence."/persist/system" = {
  directories = [
    "/etc/nixos"
    "/var/log"
    "/var/lib"
  ];
  files = [
    "/etc/machine-id"
  ];
};
fileSystems."/persist".neededForBoot = true;


  users.mutableUsers = false;
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.kidsan = {
    passwordFile = "/persist/passwords/kidsan";
   };

  programs.fuse.userAllowOther = true;
  #home-manager.users.kidsan = {pkgs, ... }: {
  #  home.homeDirectory = "/home/kidsan";
  #  home.packages = [pkgs.htop];
  #  home.stateVersion = "23.05";

  #  home.persistence."/persist/home/kidsan" = {
  #    allowOther = true;
  #    directories = [
  #      ".local/share/keyrings"
  #      ".local/share/direnv"
  #      ".ssh"
  #      "workspace"
  #      "nixos-config"
  #      {
  #        directory = ".local/share/Steam";
  #        method = "symlink";
  #      }
  #    ];
  #  };
  #};
}

