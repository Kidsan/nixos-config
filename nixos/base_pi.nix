{ config, libs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  system.stateVersion = "20.03";
  imports = [ ];

  boot = {
    loader.grub.enable = false;
    loader.generic-extlinux-compatible.enable = true;
    # kernelPackages = pkgs.linuxPackages_rpi4;
    initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  networking = {
    hostName = "newpi";
    useDHCP = false;
    interfaces.eth0.useDHCP = true;
  };

  # networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      permitRootLogin = "yes";
      passwordAuthentication = false;
   };
  };

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];

  users.users.lobster = {
    isNormalUser = true;
    home = "/home/lobster";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKas9qjJOceFVG6IS3LgH1RL0EBNZ66LFeLrsOqT31IL kidsan@thinkpad"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPkgNbqSgAdMEx/IaXFsGW6HlobqrsSnl7lanbdfMYaZ JuiceSSH"
    ];
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
