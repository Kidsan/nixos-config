{ config, libs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    weechat
    vim
    git
  ];

  system.stateVersion = "20.03";
  imports = [ ../secrets/monster.nix ];

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

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      pihole = {
        ports = [ "53:53/tcp" "53:53/udp" "67:67/udp" "80:80/tcp" ];
        image = "pihole/pihole:2022.11.2";
        extraOptions = [
          # "--restart=always"
          "--cap-add=NET_ADMIN"
        ];
        environmentFiles = [
          # /path/to/some/file
        ];
        environment = {
          TZ = "Europe/Berlin";
          WEBPASSWORD = "FOO";
          DNSMASQ_LISTENING = "ALL";
          # PIHOLE_DNS = "unbound";
          DHCP_ACTIVE = "true";
          DHCP_START = "192.168.2.100";
          DHCP_END = "192.168.2.200";

        };
        # dependsOn = [ "unbound" ];
        autoStart = true;
      };

      # unbound = {
      #   # maybe switch to nixos packaged unbound?
      #   image = "mvance/unbound:1.16.0";
      #   ports = [ "5350:53/tcp" "5350:53/udp" ];
      #   autoStart = true;
      #   volumes = [ "/home/lobster/unbound:/opt/unbound/etc/unbound/" ];
      #   extraOptions = [
      #     # "--restart=always"
      #   ];
      # };
    };
  };

}
