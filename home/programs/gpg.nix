{ config, lib, pkgs, ... }:

{

  services.gpg-agent = {
    enable = false;
    enableSshSupport = true;
    enableBashIntegration = true;
    defaultCacheTtlSsh = 36000;
    maxCacheTtlSsh = 36000;
  };

  programs.gpg.enable = true;

}
