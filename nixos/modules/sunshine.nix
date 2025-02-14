{ pkgs, ... }:

{
  services.sunshine = {
    enable = true;
    package = pkgs.sunshine.override { cudaSupport = true; };
    openFirewall = true;
    capSysAdmin = true;
  };
}
