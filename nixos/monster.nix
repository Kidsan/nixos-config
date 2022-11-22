{ config, libs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
  ];

  system.stateVersion = "20.03";
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    loader.grub.enable = false;
    # loader.raspberryPi.enable = true;
    # loader.raspberryPi.version = 4;
    loader.generic-extlinux-compatible.enable = true;
    kernelPackages = pkgs.linuxPackages_rpi4;
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # i18n.defaultLocale = "en_US.UTF-8";
  # time.timeZone = "America/Los_Angeles";

  networking = {
    hostName = "monster";
    useDHCP = false;
    interfaces.eth0.useDHCP = true;
  };

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
    passwordAuthentication = false;
    #    challengeResponseAuthentication = false;
  };

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];

  users.users.lobster = {
    isNormalUser = true;
    home = "/home/lobster";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzGxz8p3VvP+WSSQEpsh8akVnqwrfJr6Se9BtRFIyqG kidsan@thinkpad" ];
  };

}
