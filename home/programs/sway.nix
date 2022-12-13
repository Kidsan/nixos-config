{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [
    glib # gsettings
    swaylock
    swayidle
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    bemenu # wayland clone of dmenu
    xdg-utils
    waybar
  ];


  gtk = {
    enable = true;
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
    cursorTheme = {
      package = pkgs.gnome3.adwaita-icon-theme;
      name = "Adwaita";
    };
    font = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
      size = 10;
    };
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
      }
    ];
    timeouts = [
      { timeout = 1800; command = "${pkgs.swaylock}/bin/swaylock -f -c 000000"; }
      { timeout = 1800; command = ''${pkgs.sway}/bin/swaymsg "output * dpms off"' resume '${pkgs.sway}/bin/swaymsg "output * dpms on"''; }
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures = {
      gtk = true;
    };

    extraConfig = ''
      output "*" bg /home/kidsan/Pictures/wallpaper.png fill
    '';

    config = rec {
      modifier = "Mod1";
      terminal = "alacritty";
      startup = [
        { command = "sleep 5; systemctl --user restart kanshi.service"; always = true; }
      ];

      menu = "bemenu-run -H 30 --tb '#6272a4' --tf '#f8f8f2' --fb '#282a36' --ff '#f8f8f2' --nb '#282a36' --nf '#6272a4' --hb '#44475a' --hf '#50fa7b' --sb '#44475a' --sf '#50fa7b' --scb '#282a36' --scf '#ff79c6'";

      input = {
        "12815:20550:USB_HID_GMMK_Pro" = { xkb_layout = "gb"; xkb_options = "caps:escape,compose:ralt"; };
        "1133:49305:Logitech_G502_X" = { accel_profile = "flat"; pointer_accel = "-0.8"; };
      };

      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "XF86AudioRaiseVolume" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1.0'";
          "XF86AudioLowerVolume" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- -l 1.0'";
          "XF86AudioMute" = "exec 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'";
          "Print" = "exec 'FILENAME=\"screenshot-`date +%F-%T`\"; grim -g \"$(slurp)\" ~/Downloads/$FILENAME.png '";
        };

      bars = [
        {
          colors = {
            statusline = "#ffffff";
            background = "#323232";
            inactiveWorkspace = { background = "#32323200"; border = "#32323200"; text = "#5c5c5c"; };
          };
          position = "top";
          command = "waybar";
        }
      ];
    };
  };

  services.kanshi = {
    enable = true;
    profiles = {
      undocked = {
        outputs = [
          { criteria = "eDP-1"; status = "enable"; }
        ];
      };

      docked = {
        outputs = [
          { criteria = "eDP-1"; status = "disable"; }
          { criteria = "HDMI-A-1"; status = "enable"; }
        ];
      };

    };

  };

  programs.mako = {
    enable = true;
    defaultTimeout = 5000;
    ignoreTimeout = true;
  };

}
