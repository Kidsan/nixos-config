{ config, lib, pkgs, ... }:

{
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    # audacity
    transcribe
    gpu-screen-recorder
    xdotool
    chromium
    r2modman
    remmina
    discordo
  ];

  imports = [
    ./common.nix
    ../../programs/easyeffects.nix
    # ../../programs/i3.nix
    ../../programs/sway.nix
  ];

  home.file.".config/sunshine/apps.json".text = builtins.toJSON {
    env = "/run/current-system/sw/bin";
    apps = [
      {
        name = "Desktop";
        image-path = "desktop.png";
      }
      {
        name = "Low Res Desktop";
        image-path = "desktop.png";
        prep-cmd = [
          {
            do = "xrandr --output HDMI-1 --mode 1920x1080";
            undo = "xrandr --output HDMI-1 --mode 1920x1080 --output DP-1 --mode 1920x1200";
          }
        ];
      }
      {
        name = "Steam Big Picture";
        detached = [ "${pkgs.util-linux}/bin/setsid ${pkgs.steam}/bin/steam steam://open/bigpicture" ];
        output = "steam.txt";
        image-path = "steam.png";
      }
      {
        name = "Persona 5 Royal";
        detached = [ "${pkgs.util-linux}/bin/setsid ${pkgs.steam}/bin/steam steam://rungameid/1687950" ];
      }
    ];

  };

}
