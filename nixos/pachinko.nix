{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware/pachinko.nix
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

  environment.shells = [ pkgs.nushell ];

  networking.hostName = "pachinko"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  users.users.kidsan = {
    shell = pkgs.nushell;
    packages = with pkgs; [
      vim
      curl
      git
    ];
  };

  services.openssh.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?

  virtualisation.docker.enable = true;

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

