{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "~/.config/alacritty/dracula.toml"
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
    "./.config/alacritty/dracula.toml".text = /*toml*/ ''
      [colors.bright]
      black = "0x555555"
      blue = "0xcaa9fa"
      cyan = "0x8be9fd"
      green = "0x50fa7b"
      magenta = "0xff79c6"
      red = "0xff5555"
      white = "0xffffff"
      yellow = "0xf1fa8c"

      [colors.normal]
      black = "0x000000"
      blue = "0xbd93f9"
      cyan = "0x8be9fd"
      green = "0x50fa7b"
      magenta = "0xff79c6"
      red = "0xff5555"
      white = "0xbbbbbb"
      yellow = "0xf1fa8c"

      [colors.primary]
      background = "0x282a36"
      foreground = "0xf8f8f2"
    '';
  };
}
