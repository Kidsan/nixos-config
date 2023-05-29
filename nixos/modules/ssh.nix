{ pkgs, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = false;
    };
  };
  programs.ssh.extraConfig = ''
    IPQoS none
  '';

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
}
