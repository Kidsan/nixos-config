{ config, libs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    weechat
    vim
    git
  ];

  system.stateVersion = "20.03";
  imports = [
    ../secrets/monster.nix
    #./services/home-assistant.nix
    #./services/dns.nix
  ];

  boot = {
    loader.grub.enable = false;
    loader.generic-extlinux-compatible.enable = true;
    kernelPackages = pkgs.linuxPackages_rpi4;
    initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  networking = {
    hostName = "monster";
    useDHCP = false;
    wireless = {
      enable = true;
    };

    defaultGateway = "192.168.2.1";
    nameservers = [ "192.168.2.100" ];

    interfaces = {
      wlan0.ipv4.addresses = [{ address = "192.168.2.156"; prefixLength = 24; }];
      eth0.useDHCP = true;
    };
  };

  #networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
    passwordAuthentication = false;
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
      trusted-users = [ "kidsan" "lobster" ];
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

  services.tailscale.enable = true;
  networking.firewall.checkReversePath = "loose";
  virtualisation.docker.enable = true;

  services.znc = {
    enable = true;
    mutable = true;
    useLegacyConfig = false;
    openFirewall = true;
    confOptions.useSSL = false;

    configFile = config.age.secrets.znc.path;
  };

}
