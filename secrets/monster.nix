# This is imported by the monster nixos configuration module
# and triggers decryption of that secret on that host

{ config, ... }:
{

  config.age.secrets = {
    znc = {
      file = ./znc/znc.conf.age;
      owner = "znc";
      group = "znc";
      mode = "0750";
    };

    unbound = {
      name = "unbound.conf";
      path = "/home/lobster/unbound/unbound.conf";
      file = ./unbound/unbound.conf.age;
      symlink = false; # copy to destination path so that docker can mount it
    };
  };
}
