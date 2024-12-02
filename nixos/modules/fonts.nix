{ pkgs, ... }:

{
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    font-awesome # installed for waybar icons
    # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    nerd-fonts.jetbrains-mono
  ];
}
