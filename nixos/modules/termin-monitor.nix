{ pkgs, ... }:
{
  systemd.services.termin-monitor = {
    enable = true;
    # descrption = "termin-monitor";
    unitConfig = {
      After = [ "network.target" ];
    };
    serviceConfig = {
      EnvironmentFile = /etc/termin-monitor;
      ExecStart = "${pkgs.termin-monitor}/bin/termin-monitor";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
