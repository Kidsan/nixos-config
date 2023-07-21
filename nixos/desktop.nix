{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/desktop.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelModules = [ "coretemp" "nct6775" ];
  hardware.enableRedistributableFirmware = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-c1db48bc-8179-4529-945d-540de98b1a11".device = "/dev/disk/by-uuid/c1db48bc-8179-4529-945d-540de98b1a11";
  boot.initrd.luks.devices."luks-c1db48bc-8179-4529-945d-540de98b1a11".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "desktop";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    curl
    weechat
    cachix
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  virtualisation.docker.enable = true;

}


