{ pkgs, ... }:

{
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    font-awesome # installed for waybar icons
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
