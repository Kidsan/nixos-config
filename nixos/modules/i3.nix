{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.xautolock
    pkgs.lm_sensors
  ];
  programs.i3lock = {
    enable = true;
    u2fSupport = true;
  };
  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [ xterm ];
    layout = "gb,us";
    xkbVariant = ",dvp";
    xkbOptions = "caps:escape,compose:ralt,grp:ctrls_toggle";

    libinput = {
      mouse = {
        accelSpeed = "-0.5";
        accelProfile = "flat";
      };
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
      ];
    };

    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
        enableScreensaver = false;
      };
    };
    displayManager = {
      lightdm.enable = true;
      defaultSession = "xfce+i3";
    };
  };
}
