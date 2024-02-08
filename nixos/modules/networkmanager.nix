{ lib, ... }:
{

  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;
  systemd.network.wait-online.enable = false;
  networking.firewall.allowedTCPPorts = [ 11434 ];
}
