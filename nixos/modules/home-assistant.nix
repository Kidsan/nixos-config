{ config, pkgs, ... }:
{

  services.home-assistant = {
    enable = true;
    extraComponents = [
      "person"
      #      "image"
      "onboarding"
      "frontend"
      "cloud"
      "samsungtv"
    ];
    package = (pkgs.home-assistant).overrideAttrs (oldAttrs: { doInstallCheck = false; });
    config = {
      default_config = { };
      frontend = { };
      config = { };
      mobile_app = { };
      backup = { };
      zwave_js = { };
      automation = "!include automations.yaml";
      intent_script = {
        TurnOnTree = {
          speech.text = "Turned on the Tree";
          action = {
            service = "switch.turn_on";
            target.device_id = "f6e0a0e09447e0f32cdc0b27b25338dc";
          };
        };
        TurnOffTree = {
          speech.text = "Turned off the Tree";
          action = {
            service = "switch.turn_off";
            target.device_id = "f6e0a0e09447e0f32cdc0b27b25338dc";
          };
        };
      };
      conversation = {
        intents = {
          TurnOnTree = [ "Turn on the tree" ];
          TurnOffTree = [ "Turn off the tree" ];
        };
      };
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

