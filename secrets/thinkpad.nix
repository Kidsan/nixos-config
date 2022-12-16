# This is imported by the monster nixos configuration module
# and triggers decryption of that secret on that host

{ config, ... }:
{
  config.age.secrets = { };
}
