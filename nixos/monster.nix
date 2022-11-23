{ config, libs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  system.stateVersion = "20.03";
  # imports =
  #   [
  #     ./hardware-configuration.nix
  #   ];

  boot = {
    loader.grub.enable = false;
    # loader.raspberryPi.enable = true;
    # loader.raspberryPi.version = 4;
    loader.generic-extlinux-compatible.enable = true;
    kernelPackages = pkgs.linuxPackages_rpi4;
    initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  # i18n.defaultLocale = "en_US.UTF-8";
  # time.timeZone = "America/Los_Angeles";

  networking = {
    hostName = "monster";
    useDHCP = false;
    interfaces.eth0.useDHCP = true;
  };

  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
    passwordAuthentication = false;
  };

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];

  users.users.lobster = {
    isNormalUser = true;
    home = "/home/lobster";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzGxz8p3VvP+WSSQEpsh8akVnqwrfJr6Se9BtRFIyqG kidsan@thinkpad" ];
  };

  # Required for the Wireless firmware
  hardware.enableRedistributableFirmware = true;

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      experimental-features = nix-command flakes
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };

}
