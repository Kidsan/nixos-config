{ config, pkgs, ... }:
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
  ];
}
