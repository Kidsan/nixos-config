{pkgs, ...}:

{
  # kanshi systemd service
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kanshi}/bin/kanshi";
    };
  };
}
