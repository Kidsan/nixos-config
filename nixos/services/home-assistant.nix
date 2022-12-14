{ config, pkgs, ... }:
{

  services.home-assistant = {
    enable = true;
    extraComponents = [
      "zwave_js"
    ];
    openFirewall = true;
  };
}
