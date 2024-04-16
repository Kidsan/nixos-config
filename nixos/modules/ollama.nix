{ config, pkgs, lib, ... }:
{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    listenAddress = "0.0.0.0:11434";
  };
  networking.firewall.allowedTCPPorts = [ 11434 ];
}
