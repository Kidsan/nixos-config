{...}: {

  networking.firewall.allowedTCPPorts = [ 80 443 ];

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

      "znc.home" = {
        serverAliases = [ "www.znc.home" ];
        extraConfig = ''
          reverse_proxy localhost:5000
          tls internal
        '';
      };

      "git.home" = {
        serverAliases = [ "www.git.home" ];
        extraConfig = ''
          tls internal
          reverse_proxy localhost:3333
        '';
      };

    };

  };
}