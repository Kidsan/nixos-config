_:
{
  users.users.kidsan = {
    isNormalUser = true;
    description = "kidsan";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKas9qjJOceFVG6IS3LgH1RL0EBNZ66LFeLrsOqT31IL kidsan@thinkpad"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPkgNbqSgAdMEx/IaXFsGW6HlobqrsSnl7lanbdfMYaZ JuiceSSH"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPUoDNMX11//LajxTS4G0Ndj84jwh1mxn38J4g1CULhN"
    ];
  };
}
