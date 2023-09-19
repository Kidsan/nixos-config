{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/desktop.nix
    ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelModules = [ "coretemp" "nct6775" ];

  hardware.enableRedistributableFirmware = true;


  networking.hostName = "desktop";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    curl
    cachix
    virt-manager
  ];
  programs.dconf.enable = true;
  users.users.kidsan.extraGroups = [ "libvirtd" ];
  virtualisation.libvirtd.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  virtualisation.docker.enable = true;

}


