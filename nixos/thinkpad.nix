{ pkgs, ... }:

{
  imports =
    [
      ./hardware/thinkpad.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "armv7l-linux" ];

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-c797edd5-61ec-43fa-9df2-59a91f5aeb9a".device = "/dev/disk/by-uuid/c797edd5-61ec-43fa-9df2-59a91f5aeb9a";
  boot.initrd.luks.devices."luks-c797edd5-61ec-43fa-9df2-59a91f5aeb9a".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "thinkpad"; # Define your hostname.

  # Enable CUPS to print documents.
  services.printing.enable = true;
  hardware.bluetooth.enable = true;

  # Wayland stuff
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
  # gpu accelerated video playback
  hardware.opengl.extraPackages = [
    pkgs.libvdpau-va-gl
    pkgs.vaapiVdpau
  ];
  hardware.opengl.driSupport = true;
}
