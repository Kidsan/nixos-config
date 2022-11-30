{ config, ... }:
{
  config.age.secrets.znc.file = ./znc/znc.conf.age;
  config.age.secrets.znc.path = "/var/lib/znc/configs/znc.conf";
}
