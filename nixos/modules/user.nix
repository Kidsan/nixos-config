_:
{
  users.users.kidsan = {
    isNormalUser = true;
    description = "kidsan";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKas9qjJOceFVG6IS3LgH1RL0EBNZ66LFeLrsOqT31IL kidsan@thinkpad"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMAhyQg3HIZZ+XcpmIEzNkmbMUQwXX2YyjX+RTYAY6cG kidsan@phone"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPUoDNMX11//LajxTS4G0Ndj84jwh1mxn38J4g1CULhN kidsan@desktop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDj31MXtyzN28GceFMNpvXoTioUl3r+aaw4CUQuvAUm/ kidsan@macbookair"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIfLqsgzH8AdYco3e1LbE+gkIIaey/h9QgJevlEC0i67"
    ];
  };
}
