{ config, ... }:
{
  config.age.secrets.znc.file = ./znc/znc.conf.age;
  config.age.secrets.znc.path = "/var/lib/znc/configs/znc.conf";
  config.age.secrets.znc.symlink = false;
  config.age.secrets.znc.owner = "znc";
  config.age.secrets.znc.group = "znc";
  mode = "0750";
}
