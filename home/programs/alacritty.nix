{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "~/.config/alacritty/dracula.yaml"
      ];
      font = {
        size = 13;
        normal = {
          family = "JetBrains Mono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrains Mono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrains Mono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrains Mono Nerd Font";
          style = "Bold Italic";
        };
      };
    };
  };

  # Dracula theme
  home.file = {
    "./.config/alacritty/dracula.yaml".text = ''
      # Colors (Dracula)
      colors:
        # Default colors
        primary:
          background: '0x282a36'
          foreground: '0xf8f8f2'

        # Normal colors
        normal:
          black:   '0x000000'
          red:     '0xff5555'
          green:   '0x50fa7b'
          yellow:  '0xf1fa8c'
          blue:    '0xbd93f9'
          magenta: '0xff79c6'
          cyan:    '0x8be9fd'
          white:   '0xbbbbbb'

        # Bright colors
        bright:
          black:   '0x555555'
          red:     '0xff5555'
          green:   '0x50fa7b'
          yellow:  '0xf1fa8c'
          blue:    '0xcaa9fa'
          magenta: '0xff79c6'
          cyan:    '0x8be9fd'
          white:   '0xffffff'
    '';
  };
}
