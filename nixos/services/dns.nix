{ config, pkgs, ... }:
{

  services.unbound = {
    enable = true;
    settings = {
      port = "5335";
    };
  };

  services.adguardhome = {
    enable = true;
    openFirewall = true;

    mutableSettings = true;

    settings = {
      bind_port = 3000;
      dns = {
        bind_hosts = [ "0.0.0.0" ];
        port = 53;
        upstream_dns = [ "0.0.0.0:5335" ];
      };
      dhcp = {
        enabled = true;
        interface_name = "wlan0";
        dhcpv4 = {
          gateway_ip = "192.168.2.1";
          range_start = "192.168.2.100";
          subnet_mask = "255.255.255.0";
          range_end = "192.168.2.230";
          lease_duration = 0; # if 0, defaults to 24 hours
        };
      };

    };
  };

}
