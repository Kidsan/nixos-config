{ config, pkgs, lib, ... }:

{
  imports =
    [
      ../lib/cachix.nix
      ./modules/fonts.nix
      ./modules/xdg.nix
      ./modules/thunar.nix
      ./modules/weechat.nix
      ./modules/tailscale.nix
      ./modules/nix-options.nix
      ./modules/ssh.nix
      ./modules/locale.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "armv7l-linux" ];

  boot.kernelPackages = pkgs.linuxPackages_6_4;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-c797edd5-61ec-43fa-9df2-59a91f5aeb9a".device = "/dev/disk/by-uuid/c797edd5-61ec-43fa-9df2-59a91f5aeb9a";
  boot.initrd.luks.devices."luks-c797edd5-61ec-43fa-9df2-59a91f5aeb9a".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "thinkpad"; # Define your hostname.
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kidsan = {
    isNormalUser = true;
    description = "kidsan";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Wayland stuff
  programs.dconf.enable = true;
  security.pam.services.swaylock = { }; # allows swaylock check if password is correct
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    slack
    thunderbird
    ntfs3g
    exfat
    cachix
    xfce.thunar
    xfce.thunar-volman
    weechat
  ];

  environment.pathsToLink = [ "/share/bash-completion" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  virtualisation.docker.enable = true;

  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = [
    pkgs.libvdpau-va-gl
    pkgs.vaapiVdpau
  ];
  hardware.opengl.driSupport = true;
}
