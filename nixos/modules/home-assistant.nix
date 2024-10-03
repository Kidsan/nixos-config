{ config, pkgs, ... }:
{

  # services.home-assistant = {
  #   enable = true;
  #   extraComponents = [
  #     "person"
  #     #      "image"
  #     "onboarding"
  #     "frontend"
  #     "cloud"
  #     "samsungtv"
  #   ];
  #   package = (pkgs.home-assistant).overrideAttrs (oldAttrs: { doInstallCheck = false; });
  #   config = {
  #     default_config = { };
  #     frontend = { };
  #     config = { };
  #     mobile_app = { };
  #     backup = { };
  #     zwave_js = { };
  #     automation = "!include automations.yaml";
  #     intent_script = {
  #       TurnOnTree = {
  #         speech.text = "Turned on the Tree";
  #         action = {
  #           service = "switch.turn_on";
  #           target.device_id = "f6e0a0e09447e0f32cdc0b27b25338dc";
  #         };
  #       };
  #       TurnOffTree = {
  #         speech.text = "Turned off the Tree";
  #         action = {
  #           service = "switch.turn_off";
  #           target.device_id = "f6e0a0e09447e0f32cdc0b27b25338dc";
  #         };
  #       };
  #     };
  #     conversation = {
  #       intents = {
  #         TurnOnTree = [ "Turn on the tree" ];
  #         TurnOffTree = [ "Turn off the tree" ];
  #       };
  #     };
  #   };
  #   configWritable = true;
  #   openFirewall = true;
  # };

  networking.firewall.allowedTCPPorts = [ 67 68 80 443 2222 ];
  networking.firewall.allowedUDPPorts = [ 53 67 ];
  networking.networkmanager.insertNameservers = [ "192.168.2.175" ];
  virtualisation.oci-containers = {
    containers.home-assistant = {
      volumes = [ "/etc/home-assistant:/config" ];
      image = "ghcr.io/home-assistant/home-assistant:stable";
      autoStart = true;
      ports = [
        "8123:8123"
      ];
      extraOptions = [
        #"--network=host"
        #"--restart-unless-stopped"
        "--privileged"
      ];
    };

  };


}

