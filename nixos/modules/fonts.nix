{ pkgs, ... }:

{
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    font-awesome # installed for waybar icons
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
