{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.mangohud ]; # used for limiting fps via steam command parameters
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    package = with pkgs; steam.override { extraPkgs = pkgs: [ attr ]; };
  };
}
