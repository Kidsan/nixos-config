{ ... }:
{
  services.tt-rss = {
    enable = true;
    singleUserMode = true;
    selfUrlPath = "http://192.168.2.156";
  };
  networking.firewall.allowedTCPPorts = [ 80 ];
}
