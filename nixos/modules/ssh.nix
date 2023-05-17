{ pkgs, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      permitRootLogin = "yes";
      passwordAuthentication = false;
    };
  };
  programs.ssh.extraConfig = ''
    IPQoS none
  '';

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
}
