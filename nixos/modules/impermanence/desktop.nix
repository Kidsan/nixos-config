# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ ... }:
{
  environment.persistence."/persist/system" = {
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.kidsan = {
      directories = [
        { directory = ".config/discord"; mode = "0700"; user = "kidsan"; }
        { directory = ".config/systemd"; user = "kidsan"; }
        { directory = ".config/easyeffects"; user = "kidsan"; }
        { directory = ".config/i3"; user = "kidsan"; }
        { directory = ".local/share/direnv"; user = "kidsan"; }
        { directory = ".local/share/keyrings"; user = "kidsan"; }
        { directory = ".local/share/nvim"; user = "kidsan"; }
        { directory = ".local/share/Steam"; user = "kidsan"; }
        { directory = ".local/state/nix"; mode = "0700"; user = "kidsan"; }
        { directory = ".mozilla"; mode = "0700"; user = "kidsan"; }
        { directory = ".ssh"; user = "kidsan"; }
        { directory = "nixos-config"; user = "kidsan"; }
        { directory = "workspace"; user = "kidsan"; }
      ];
      files = [
        { file = ".bash_history"; }
      ];
    };
  };
  fileSystems."/persist".neededForBoot = true;

  programs.fuse.userAllowOther = true; # requied for home-manager impermanence

  security.sudo.extraConfig = ''
    # rollback results in sudo lectures after each reboot
    Defaults lecture = never
  '';
}

