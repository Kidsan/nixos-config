{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver = {
    layout = "gb,us";
    xkbVariant = ",dvp";
    xkbOptions = "caps:escape,compose:ralt,grp:ctrls_toggle";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
}
