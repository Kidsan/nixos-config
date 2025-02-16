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

}
