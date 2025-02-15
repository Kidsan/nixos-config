{ pkgs, ... }:
{
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";
  services.tailscale.permitCertUid = "caddy";
  networking.firewall.checkReversePath = "loose";
}
