{ config, pkgs, lib, ... }:
{
  imports = [
    ./home-assistant.nix
    ./unbound.nix
    ./caddy.nix
    ./adguard.nix
    ./zwave_ui.nix
    ./znc.nix
    ./forgejo.nix
    ./sponsorblock.nix
    ./ttrss.nix
    ./grafana.nix
  ];

  services.audiobookshelf = {
      enable = true;
      port = 8724;
  };

  services.calibre-server.enable = true;
  services.calibre-server.port = 8725;
  services.calibre-server.extraFlags = [
  "--enable-local-write"
  ];
}
