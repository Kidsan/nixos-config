# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware/pachinko.nix
      # "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
      ./modules/disko/pachinko.nix

      ./modules/tailscale.nix
      ./modules/nix-options.nix
      ./modules/linux-kernel.nix
      ./modules/upgrades.nix
      ./modules/ssh.nix
      ./modules/user.nix
    ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;

  networking.hostName = "pachinko"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  users.users.kidsan = {
    packages = with pkgs; [
      vim
      curl
      git
    ];
  };

  services.openssh.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?

}

