{ config, pkgs, lib, ... }:

{
  imports =
    [
      ../lib/cachix.nix
      ./modules/fonts.nix
      ./modules/kde.nix
      ./modules/nix-options.nix
      ./modules/ssh.nix
      ./modules/steam.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelPackages = pkgs.linuxPackages_6_3;
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
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;
  systemd.network.wait-online.enable = false;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_GB.utf8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.utf8";
    LC_IDENTIFICATION = "de_DE.utf8";
    LC_MEASUREMENT = "de_DE.utf8";
    LC_MONETARY = "de_DE.utf8";
    LC_NAME = "de_DE.utf8";
    LC_NUMERIC = "de_DE.utf8";
    LC_PAPER = "de_DE.utf8";
    LC_TELEPHONE = "de_DE.utf8";
    LC_TIME = "de_DE.utf8";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.kidsan = {
    isNormalUser = true;
    description = "kidsan";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    packages = with pkgs; [
      kate
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    curl
    weechat
    cachix
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  virtualisation.docker.enable = true;

  documentation.nixos.enable = false;
  programs.noisetorch.enable = true;
  programs.dconf.enable = true;
}


