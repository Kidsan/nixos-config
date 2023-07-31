{ config, lib, pkgs, ... }:

{

  programs.bash.bashrcExtra = ''
    if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
      exec i3
    fi
  '';

  home.packages = with pkgs; [
    glib # gsettings
    bemenu # wayland clone of dmenu
    xdg-utils
  ];

  xsession.windowManager.i3 = {
    enable = true;

    #extraConfig = ''
    #  output "*" bg /home/kidsan/Pictures/wallpaper.png fill
    #'';

    config = rec {
      modifier = "Mod1";
      terminal = "alacritty";
      startup = [
        { command = "firefox"; }
      ];

      menu = "bemenu-run -H 30 --tb '#6272a4' --tf '#f8f8f2' --fb '#282a36' --ff '#f8f8f2' --nb '#282a36' --nf '#6272a4' --hb '#44475a' --hf '#50fa7b' --sb '#44475a' --sf '#50fa7b' --scb '#282a36' --scf '#ff79c6'";

      keybindings =
        let
          inherit (config.xsession.windowManager.i3.config) modifier;
        in
        lib.mkOptionDefault {
          "XF86AudioRaiseVolume" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1.0'";
          "XF86AudioLowerVolume" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- -l 1.0'";
          "XF86AudioMute" = "exec 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'";
        };

      bars = [
        {
          colors = {
            statusline = "#ffffff";
            background = "#323232";
            inactiveWorkspace = { background = "#32323200"; border = "#32323200"; text = "#5c5c5c"; };
          };
          position = "top";
          command = "i3bar";
        }
      ];

    };
  };

  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    ignoreTimeout = true;
    extraConfig = ''
      background-color=#282a36
      text-color=#ffffff
      border-color=#282a36

      [urgency=low]
      border-color=#282a36

      [urgency=normal]
      border-color=#f1fa8c

      [urgency=high]
      border-color=#ff5555
    '';
  };

}
