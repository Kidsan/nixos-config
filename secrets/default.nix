{ config, ... }:
{

  config.age.secrets = {
    znc = {
      file = ./znc/znc.conf.age;

      # path = "/var/lib/znc/configs/znc.conf";
      # symlink = false;
      owner = "znc";
      group = "znc";
      mode = "0750";
    };
  };
}
