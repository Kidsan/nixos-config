{ config, lib, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "kidsan";
  home.homeDirectory = "/home/kidsan";

  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    glib # gsettings
    swaylock
    swayidle
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    bemenu # wayland clone of dmenu
    pulseaudio # we only use pactl - investigate switching this to pipewire-pulse
    spotify
    discord
    element-desktop
    chromium
    xdg-utils
  ];

  programs.mako = {
    enable = true;
    defaultTimeout = 5;
    ignoreTimeout = true;
  };

  programs.git = {
    enable = true;
    userName = "kidsan";
    userEmail = "8798449+Kidsan@users.noreply.github.com";
    ignores = [ "*.nix" "flake.lock" "!personal/**/*.nix" "!personal/**/flake.lock" "!nixos-config/**/*.nix" "!nixos-config/**/flake.lock" ];
    extraConfig = { init = { defaultBranch = "main"; }; pull = { rebase = true; }; };
  };

  programs.alacritty = {
    enable = true;
    settings = { };
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimAlias = true;
    extraConfig = ''
      set number

      :map <Up> <Nop>
      :map <Left> <Nop>
      :map <Right> <Nop>
      :map <Down> <Nop>
    '';
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = [
      pkgs.vscode-extensions.rust-lang.rust-analyzer
      pkgs.vscode-extensions.golang.go
      pkgs.vscode-extensions.humao.rest-client
      pkgs.vscode-extensions.jnoortheen.nix-ide
      pkgs.vscode-extensions.eamodio.gitlens
    ];
    enableUpdateCheck = false;

    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "editor.formatOnSave" = true;
      "nix.serverSettings" = {
        "nil" = {
          "diagnostics" = {
            "ignored" = [
              "unused_binding"
              "unused_with"
              "unused_rec"
            ];
          };
          "formatting" = {
            "command" = [
              "nixpkgs-fmt"
            ];
          };
        };
      };
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

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
        command = "swaylock -f -c 000000";
      }
    ];
    timeouts = [
      { timeout = 300; command = "swaylock -f -c 000000"; }
      { timeout = 600; command = ''swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"''; }
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures = {
      gtk = true;
    };

    config = rec {
      modifier = "Mod1";
      terminal = "alacritty";
      startup = [
        { command = "sleep 5; systemctl --user start kanshi.service"; }
      ];

      menu = "bemenu-run";

      input = {
        "*" = { xkb_layout = "gb"; xkb_options = "caps:escape,compose:ralt"; };
        "1133:49305:Logitech_G502_X" = { accel_profile = "flat"; pointer_accel = "-0.8"; };
      };

      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +2%'";
          "XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -2%'";
          "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
        };

      bars = [
        {
          colors = {
            statusline = "#ffffff";
            background = "#323232";
            inactiveWorkspace = { background = "#32323200"; border = "#32323200"; text = "#5c5c5c"; };
          };
          position = "top";
          statusCommand = "while date +'%Y-%m-%d %I:%M:%S %p'; do sleep 1; done";
          fonts = { };
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
}
