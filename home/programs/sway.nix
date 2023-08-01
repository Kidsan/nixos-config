{ config, lib, pkgs, ... }:

{

  programs.bash.bashrcExtra = ''
    if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
      exec sway
    fi
  '';

  home.packages = with pkgs; [
    playerctl
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
      {
        timeout = 1800;
        command = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
      }
      {
        timeout = 1800;
        command = ''${pkgs.sway}/bin/swaymsg "output * power off" '';
        resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * power on"'';
      }
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

    config = {
      modifier = "Mod1";
      terminal = "alacritty";
      startup = [
        { command = "sleep 5; systemctl --user restart kanshi.service"; always = true; }
        { command = "firefox"; }
        { command = "slack"; }
        { command = "thunderbird"; }
      ];

      menu = "bemenu-run -H 30 --tb '#6272a4' --tf '#f8f8f2' --fb '#282a36' --ff '#f8f8f2' --nb '#282a36' --nf '#6272a4' --hb '#44475a' --hf '#50fa7b' --sb '#44475a' --sf '#50fa7b' --scb '#282a36' --scf '#ff79c6'";

      input = {
        "12815:20550:USB_HID_GMMK_Pro" = {
          xkb_layout = "gb,us";
          xkb_variant = ",dvp";
          xkb_options = "caps:escape,compose:ralt,grp:ctrls_toggle";
        };
        "1133:49305:Logitech_G502_X" = {
          accel_profile = "flat";
          pointer_accel = "-0.8";
        };
        "1:1:AT_Translated_Set_2_keyboard" = {
          xkb_layout = "gb,us";
          xkb_variant = ",dvp";
          xkb_options = "caps:escape,compose:ralt,grp:ctrls_toggle";
        };
      };

      keybindings =
        let
          inherit (config.wayland.windowManager.sway.config) modifier;
        in
        lib.mkOptionDefault {
          "XF86AudioRaiseVolume" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1.0'";
          "XF86AudioLowerVolume" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- -l 1.0'";
          "XF86AudioMute" = "exec 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'";
          "Print" = "exec 'FILENAME=\"screenshot-`date +%F-%T`\"; grim -g \"$(slurp)\" ~/Downloads/$FILENAME.png '";
          "${modifier}+period" = "playerctl -p spotify next";
          "${modifier}+comma" = "playerctl -p spotify previous";
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

      assigns = {
        "1" = [{ app_id = "firefox-nightly"; }];
        "2" = [{ app_id = "thunderbird"; } { app_id = "Slack"; }];
        "4" = [{ class = "discord"; } { class = "Spotify"; }];
      };
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
          { criteria = "eDP-1"; status = "enable"; }
          { criteria = "HDMI-A-1"; status = "enable"; }
        ];
      };

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

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        height = 30;
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "custom/media"
          "bluetooth"
          #"network"
          "cpu"
          "temperature"
          "sway/language"
          "battery"
          "pulseaudio"
          "tray"
          "clock#date"
          "clock#time"
        ];

        battery = {
          "interval" = 10;
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          # Connected to AC
          "format" = "  {icon}  {capacity}%"; # Icon: bolt
          # Not connected to AC
          "format-discharging" = "{icon}  {capacity}%";
          "format-icons" = [
            "" # Icon= battery-full
            "" # Icon= battery-three-quarters
            "" # Icon= battery-half
            "" # Icon= battery-quarter
            "" # Icon= battery-empty
          ];
          "tooltip" = true;
        };
        "clock#time" = {
          interval = 1;
          format = "{:%H:%M:%S}";
          tooltip = true;
        };
        "clock#date" = {
          interval = 10;
          format = "  {:%e %b %Y}";
          # "tooltip-format" = "{:%e %B %Y}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
        };
        "cpu" = {
          interval = 5;
          format = "  {usage}%";
          states = {
            warning = 70;
            critical = 90;
          };
        };
        #"custom/keyboard-layout" = {
        #  exec = "swaymsg -t get_inputs | grep -m1 'xkb_active_layout_name' | cut -d '\"' -f4";
        #  interval = 30;
        #  format = "  {}";
        #  signal = 1;
        #  tooltip = false;
        #};
        "sway/language" = {
          "format" = "{variant}";
          "on-click" = "swaymsg input type:keyboard xkb_switch_layout next";
        };
        memory = {
          interval = 5;
          format = "  {}%";
          states = {
            warning = 70;
            critical = 90;
          };
        };
        network = {
          interval = 5;
          "format-wifi" = "  {essid} ({signalStrength}%)";
          "format-ethernet" = "  {ifname}: {ipaddr}/{cidr}";
          "format-disconnected" = "⚠  Disconnected";
          "tooltip-format" = "{ifname}: {ipaddr}";

        };
        "sway/mode" = {
          "format" = "<span style=\"italic\">  {}</span>";
          "tooltip" = false;
        };
        "sway/window" = {
          format = "{}";
          "max-length" = 120;
        };
        "sway/workspaces" = {
          "all-outputs" = false;
          "disable-scroll" = true;
          format = "{icon} {name}";
          "format-icons" = {
            "1" = ""; #/ FF logo
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "urgent" = "";
            "focused" = "";
            "default" = "";
          };
        };
        pulseaudio = {
          "scroll-step" = 2;
          "format" = "{icon}  {volume}%";
          #"format-bluetooth"= "{icon}  {volume}%";
          "format-muted" = "";
          "format-icons" = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "" "" ];
          };
          "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
        temperature = {
          "critical-threshold" = 80;
          "interval" = 5;
          "format" = "{icon}  {temperatureC}°C";
          "format-icons" = [
            "" #/ Icon: temperature-empty
            "" #/ Icon: temperature-quarter
            "" #/ Icon: temperature-half
            "" #/ Icon: temperature-three-quarters
            "" #/ Icon: temperature-full
          ];
          "tooltip" = true;
        };
        "tray" = {
          "icon-size" = 21;
          "spacing" = 10;
        };

        "bluetooth" = {
          "format" = " {status}";
          "format-connected" = " {device_alias}";
          "format-connected-battery" = " {device_alias} {device_battery_percentage}%";
          #/ "format-device-preference": [ "device1", "device2" ], // preference list deciding the displayed device
          "tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          "tooltip-format-connectee" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          "tooltip-format-enumerate-connected-battery" = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          "on-click-right" = "rfkill toggle bluetooth";
        };

        "custom/media" = {
          "exec-if" = "pgrep spotify";
          "format" = "{icon} {}";
          "return-type" = "json";
          "smooth-scrolling-threshold" = 1;
          "on-scroll-up" = "playerctl -p spotify next";
          "on-scroll-down" = "playerctl -p spotify previous";
          "format-icons" = {
            "Playing" = "";
            "Paused" = "";
          };
          "max-length" = 30;
          "exec" = "playerctl -p spotify -a metadata --format '{\"text\": \"{{markup_escape(title)}} - {{artist}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          "on-click" = "playerctl -p spotify play-pause";
        };
      };

    };
    style = ''
      /* =============================================================================
       *
       * Waybar configuration
       *
       * Configuration reference: https://github.com/Alexays/Waybar/wiki/Configuration
       *
       * =========================================================================== */

      /* -----------------------------------------------------------------------------
       * Keyframes
       * -------------------------------------------------------------------------- */

      @keyframes blink-warning {
          70% {
              color: white;
          }

          to {
              color: white;
              background-color: orange;
          }
      }

      @keyframes blink-critical {
          70% {
              color: white;
          }

          to {
              color: white;
              background-color: red;
          }
      }


      /* -----------------------------------------------------------------------------
       * Base styles
       * -------------------------------------------------------------------------- */

      /* Reset all styles */
      * {
          border: none;
          border-radius: 0;
          min-height: 0;
          margin: 0;
          padding: 0;
      }

      /* The whole bar */
      #waybar {
          /* background: #323232; */
          background: @theme_base_color;
          /* color: white; */
          color: @theme_text_color;
          font-family: JetBrains Mono Nerd Font, Cantarell, Noto Sans, sans-serif;
          font-size: 13px;
      }

      /* Each module */
      #battery,
      #clock,
      #cpu,
      #custom-keyboard-layout,
      #memory,
      #custom-media
      #bluetooth,
      #mode,
      #network,
      #pulseaudio,
      #temperature,
      #tray {
          padding-left: 10px;
          padding-right: 10px;
      }


      /* -----------------------------------------------------------------------------
       * Module styles
       * -------------------------------------------------------------------------- */

      #battery {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #battery.warning {
          color: orange;
      }

      #battery.critical {
          color: red;
      }

      #battery.warning.discharging {
          animation-name: blink-warning;
          animation-duration: 3s;
      }

      #battery.critical.discharging {
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      #clock {
          font-weight: bold;
      }

      #cpu {
          /* No styles */
      }

      #cpu.warning {
          color: orange;
      }

      #cpu.critical {
          color: red;
      }

      #memory {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #memory.warning {
          color: orange;
      }

      #memory.critical {
          color: red;
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      #mode {
          background: #64727D;
          border-top: 2px solid white;
          /* To compensate for the top border and still have vertical centering */
          padding-bottom: 2px;
      }

      #network {
          /* No styles */
      }

      #network.disconnected {
          color: orange;
      }

      #pulseaudio {
          /* No styles */
      }

      #pulseaudio.muted {
          /* No styles */
      }

      #custom-media {
          color: rgb(102, 220, 105);
          padding-left: 20px;
          padding-right: 20px;
      }

      #temperature {
          /* No styles */
      }

      #temperature.critical {
          color: red;
      }

      #tray {
          /* No styles */
      }

      #window {
          font-weight: bold;
      }

      #workspaces button {
          border-top: 2px solid transparent;
          /* To compensate for the top border and still have vertical centering */
          padding-bottom: 2px;
          padding-left: 10px;
          padding-right: 10px;
          color: #888888;
      }

      #workspaces button.focused {
          border-color: #4c7899;
          color: white;
          background-color: #285577;
      }

      #workspaces button.urgent {
          border-color: #c9545d;
          color: #c9545d;
      }
    '';

  };
}
