# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ ... }:
{
  environment.persistence."/persist/system" = {
    directories = [
      "/etc/ssh"
      "/etc/nixos"
      "/var/log"
      "/var/lib"
      "/var/lib/nixos"
      "/etc/sponsorblocktv"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.kidsan = {
      directories = [
        { directory = ".config/discord"; mode = "0700"; user = "kidsan"; }
        { directory = ".config/systemd"; user = "kidsan"; }
        { directory = ".config/Element"; user = "kidsan"; }
        { directory = ".config/weechat"; user = "kidsan"; }
        { directory = ".config/spotify"; user = "kidsan"; }
        { directory = ".config/Signal"; user = "kidsan"; }
        { directory = ".config/openxr"; user = "kidsan"; }
        { directory = ".config/openvr"; user = "kidsan"; }
        { directory = ".config/BeatSaberModManager"; user = "kidsan"; }
        { directory = ".config/Valve"; user = "kidsan"; }
        { directory = ".config/alvr"; user = "kidsan"; }
        { directory = ".config/dconf"; user = "kidsan"; }
        { directory = ".config/sunshine"; user = "kidsan"; }
        { directory = ".config/easyeffects"; user = "kidsan"; }
        { directory = ".config/obs-studio"; user = "kidsan"; }
        { directory = ".config/github-copilot"; user = "kidsan"; }
        { directory = "Games"; user = "kidsan"; }
        { directory = ".config/i3"; user = "kidsan"; }
        { directory = ".config/vlc"; user = "kidsan"; }
        { directory = ".config/xfce4"; user = "kidsan"; }
        { directory = ".local/share/direnv"; user = "kidsan"; }
        { directory = ".local/share/keyrings"; user = "kidsan"; }
        { directory = ".local/share/lutris"; user = "kidsan"; }
        { directory = ".local/share/nvim"; user = "kidsan"; }
        { directory = ".local/share/Steam"; user = "kidsan"; }
        { directory = ".local/share/ALVR-Launcher"; user = "kidsan"; }
        { directory = ".local/state/nix"; mode = "0700"; user = "kidsan"; }
        { directory = ".mozilla"; mode = "0700"; user = "kidsan"; }
        { directory = ".factorio"; user = "kidsan"; }
        { directory = ".ssh"; user = "kidsan"; }
        { directory = "nixos-config"; user = "kidsan"; }
        { directory = "workspace"; user = "kidsan"; }
        { directory = ".config/i3blocks"; user = "kidsan"; }
        { directory = ".ollama"; user = "kidsan"; }
        { directory = "Videos/replay"; user = "kidsan"; }
        { directory = "Zomboid"; user = "kidsan"; }
        { directory = ".supermaven"; user = "kidsan"; }
        { directory = ".config/exercism"; user = "kidsan"; }
      ];
      files = [
        { file = ".local/share/rippkgs-index.sqlite"; }
        { file = ".bash_history"; }
        { file = ".config/nushell/history.txt"; }
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

