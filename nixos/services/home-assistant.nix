{ config, pkgs, ... }:
{

  services.home-assistant = {
    enable = true;
    extraComponents = [
      "person"
      "image"
      "onboarding"
      "frontend"
      "cloud"
    ];
    config = {
      default_config = { };
      frontend = { };
      config = { };
      mobile_app = { };
      backup = { };
      zwave_js = { };
      automation = "!include automations.yaml";
    };
    configWritable = true;
    openFirewall = true;
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers.zwave_ui = {
      volumes = [ "/var/lib/zwavejs/store:/usr/src/app/store" ];
      image = "zwavejs/zwave-js-ui:latest";
      ports = [ "3000:3000" "8091:8091" ];
      autoStart = true;
      extraOptions = [
        "--device=/dev/ttyUSB0:/dev/zwave"
      ];
    };
  };
}
