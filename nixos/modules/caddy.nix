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
      "http://ha.home" = {
        serverAliases = [ "http://www.ha.home" ];
        extraConfig = ''
          reverse_proxy localhost:8123
          # tls internal
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

      "rss.home" = {
        serverAliases = [ "www.rss.home" ];
        extraConfig = ''
          root * /var/lib/tt-rss/www
          file_server
          php_fastcgi unix//run/phpfpm/tt-rss.sock
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

      "http://audiobookshelf.home" = {
          serverAliases = [ "http://www.audiobookshelf.home" ];
          extraConfig = ''
            encode zstd gzip
            reverse_proxy localhost:8724
          '';
      };

      "pachinko.taila4d46.ts.net" = {
          serverAliases = [ "https://pachinko.taila4d46.ts.net" ];
          extraConfig = ''
            encode zstd gzip
            reverse_proxy localhost:8724
          '';
      };
    };

  };
}
