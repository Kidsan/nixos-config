{ config, lib, ... }:
{
  services.grafana = {
      enable = true;
      settings = {
          security = {
              admin_user = "admin";
              admin_password = lib.mkForce "$__file{${config.age.secrets.grafana_admin_password.path}}";
          };
      };
  };

  services.prometheus = {
      enable = true;
      remoteWrite = [{
          url = "https://prometheus-prod-24-prod-eu-west-2.grafana.net/api/prom/push";
          basic_auth = {
              username = "1571875";
              password_file = config.age.secrets.prometheus_push_password.path;
          };
      }];
      scrapeConfigs = [{
          job_name = "node";
          static_configs = [{
              targets = [ "localhost:9100" ];
          }];
      }];
      exporters = {
          node.enable = true;
          node.enabledCollectors = [ "systemd" "processes" ];
      };
  };

}
