{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.xautolock
    pkgs.lm_sensors
    pkgs.i3blocks
  ];
	environment.xfce.excludePackages = [
	  pkgs.xfce.xfce4-power-manager
	];
  programs.i3lock = {
    enable = true;
    u2fSupport = true;
  };

  services = {
    libinput = {
      enable = true;
      mouse = {
        accelSpeed = "-0.8";
        accelProfile = "flat";
      };
    };
  };
  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [ xterm ];
    xkb = {
      layout = "gb,us";
      variant = ",dvp";
      options = "caps:escape,compose:ralt,grp:ctrls_toggle";
    };

    exportConfiguration = true;
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
    };
  };
  services.displayManager.defaultSession = "xfce+i3";
}
