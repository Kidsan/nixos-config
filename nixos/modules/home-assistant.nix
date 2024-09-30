{ config, pkgs, ... }:
{

  # services.home-assistant = {
  #   enable = true;
  #   extraComponents = [
  #     "person"
  #     #      "image"
  #     "onboarding"
  #     "frontend"
  #     "cloud"
  #     "samsungtv"
  #   ];
  #   package = (pkgs.home-assistant).overrideAttrs (oldAttrs: { doInstallCheck = false; });
  #   config = {
  #     default_config = { };
  #     frontend = { };
  #     config = { };
  #     mobile_app = { };
  #     backup = { };
  #     zwave_js = { };
  #     automation = "!include automations.yaml";
  #     intent_script = {
  #       TurnOnTree = {
  #         speech.text = "Turned on the Tree";
  #         action = {
  #           service = "switch.turn_on";
  #           target.device_id = "f6e0a0e09447e0f32cdc0b27b25338dc";
  #         };
  #       };
  #       TurnOffTree = {
  #         speech.text = "Turned off the Tree";
  #         action = {
  #           service = "switch.turn_off";
  #           target.device_id = "f6e0a0e09447e0f32cdc0b27b25338dc";
  #         };
  #       };
  #     };
  #     conversation = {
  #       intents = {
  #         TurnOnTree = [ "Turn on the tree" ];
  #         TurnOffTree = [ "Turn off the tree" ];
  #       };
  #     };
  #   };
  #   configWritable = true;
  #   openFirewall = true;
  # };

  services.unbound = {
    enable = true;
    checkconf = true;

    settings = {
      server = {
        verbosity = 0;

        interface = "127.0.0.1";
        port = 5335;
        do-ip4 = true;
        do-udp = true;
        do-tcp = true;

        # May be set to yes if you have IPv6 connectivity
        do-ip6 = false;

        # You want to leave this to no unless you have *native* IPv6. With 6to4 and
        # Terredo tunnels your web browser should favor IPv4 for the same reasons
        prefer-ip6 = false;

        # Use this only when you downloaded the list of primary root servers!
        # If you use the default dns-root-data package, unbound will find it automatically
        #root-hints: "/var/lib/unbound/root.hints"

        # Trust glue only if it is within the server's authority
        harden-glue = true;

        # Require DNSSEC data for trust-anchored zones, if such data is absent, the zone becomes BOGUS
        harden-dnssec-stripped = true;

        # Don't use Capitalization randomization as it known to cause DNSSEC issues sometimes
        # see https://discourse.pi-hole.net/t/unbound-stubby-or-dnscrypt-proxy/9378 for further details
        use-caps-for-id = false;

        # Reduce EDNS reassembly buffer size.
        # IP fragmentation is unreliable on the Internet today, and can cause
        # transmission failures when large DNS messages are sent via UDP. Even
        # when fragmentation does work, it may not be secure; it is theoretically
        # possible to spoof parts of a fragmented DNS message, without easy
        # detection at the receiving end. Recently, there was an excellent study
        # >>> Defragmenting DNS - Determining the optimal maximum UDP response size for DNS <<<
        # by Axel Koolhaas, and Tjeerd Slokker (https://indico.dns-oarc.net/event/36/contributions/776/)
        # in collaboration with NLnet Labs explored DNS using real world data from the
        # the RIPE Atlas probes and the researchers suggested different values for
        # IPv4 and IPv6 and in different scenarios. They advise that servers should
        # be configured to limit DNS messages sent over UDP to a size that will not
        # trigger fragmentation on typical network links. DNS servers can switch
        # from UDP to TCP when a DNS response is too big to fit in this limited
        # buffer size. This value has also been suggested in DNS Flag Day 2020.
        edns-buffer-size = 1232;

        # Perform prefetching of close to expired message cache entries
        # This only applies to domains that have been frequently queried
        prefetch = true;

        # One thread should be sufficient, can be increased on beefy machines. In reality for most users running on small networks or on a single machine, it should be unnecessary to seek performance enhancement by increasing num-threads above 1.
        num-threads = 1;

        # Ensure kernel buffer is large enough to not lose messages in traffic spikes
        so-rcvbuf = "1m";

        # Ensure privacy of local IP ranges
        private-address = [
          "192.168.0.0/16"
          "169.254.0.0/16"
          "172.16.0.0/12"
          "10.0.0.0/8"
          "fd00::/8"
          "fe80::/10"
        ];
      };


    };

  };

  services.caddy = {
    enable = true;
    virtualHosts = {
      "adguard.home" = {
        serverAliases = [ "www.adguard.home" ];
        extraConfig = ''
          reverse_proxy localhost:8080
          tls internal
        '';
      };
      "ha.home" = {
        serverAliases = [ "www.ha.home" ];
        extraConfig = ''
          reverse_proxy localhost:8123
          tls internal
        '';
      };

      "zwave.home" = {
        serverAliases = [ "www.zwave.home" ];
        extraConfig = ''
          reverse_proxy localhost:8091
          tls internal
        '';
      };

    };

  };

  services.adguardhome = {
    enable = true;
    openFirewall = true;
    allowDHCP = true;
    port = 8080;
  };

  networking.firewall.allowedTCPPorts = [ 67 68 80 443 ];
  networking.firewall.allowedUDPPorts = [ 53 67 ];
  virtualisation.oci-containers = {
    backend = "docker";

    containers.home-assistant = {
      volumes = [ "/etc/home-assistant:/config" ];
      image = "ghcr.io/home-assistant/home-assistant:stable";
      autoStart = true;
      ports = [
        "8123:8123"
      ];
      extraOptions = [
        #"--network=host"
        #"--restart-unless-stopped"
        "--privileged"
      ];
    };

    containers.zwave_ui = {
      volumes = [ "/var/lib/zwavejs/store:/usr/src/app/store" ];
      image = "zwavejs/zwave-js-ui:latest";
      ports = [ "3003:3000" "8091:8091" ];
      autoStart = true;
      extraOptions = [
        # "--device=/dev/ttyUSB0:/dev/zwave"
      ];
    };
  };
}

