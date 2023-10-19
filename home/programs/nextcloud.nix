{ pkgs, ... }:
{

  systemd.user.services = {
    nextcloud-sync = {
      Unit = {
        Description = "Zettelkasten Sync";
        After = "sway-session.target";
        PartOf = "sway-session.target";
        Requires = "sway-session.target";
      };
      Install = {
        WantedBy = [ "sway-session.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.writeShellScript "sync-zettelkasten" ''
          #!/run/current-system/sw/bin/bash
          ${pkgs.nextcloud-client}/bin/nextcloudcmd --path /zettelkasten -n ~/zettelkasten <server-url>
        ''}";
      };
    };
  };

  systemd.user.timers = {
    nextcloud-sync = {
      Unit = {
        After = "sway-session.target";
        PartOf = "sway-session.target";
        Requires = "sway-session.target";
      };
      Timer = {
        OnCalendar = "hourly";
        Persistent = "true";
      };
      Install = {
        WantedBy = [ "sway-session.target" ];
      };
    };
  };
}

