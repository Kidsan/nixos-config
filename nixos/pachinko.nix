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
      ./modules/homelab.nix
    ];

  networking.firewall.allowedTCPPorts = [22];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;

  environment.shells = [ pkgs.nushell ];

  networking.hostName = "pachinko"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  environment.systemPackages = [
    pkgs.vim
  ];

  users.users.kidsan = {
    shell = pkgs.nushell;
    packages = with pkgs; [
      vim
      curl
      git
      zip
    ];
  };

  services.openssh.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?

  virtualisation.docker.enable = true;
  virtualisation.oci-containers = {
    backend = "docker";
  };

  services.davfs2 = {
    enable = true;
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;
  systemd.network.wait-online.enable = false;

}

