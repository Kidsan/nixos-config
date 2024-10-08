{...}: {

  networking.networkmanager.insertNameservers = [ "192.168.2.133" ];
  networking.firewall.allowedTCPPorts = [ 67 ];
  networking.firewall.allowedUDPPorts = [ 53 67 ];
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    allowDHCP = true;
    port = 8080;
  };
}
