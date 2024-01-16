{ pkgs, ... }:
{
  xdg = {
    portal = {
      enable = true;
      config.common.default = "*";
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };
}
