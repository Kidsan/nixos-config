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
  };
}
