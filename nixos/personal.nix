{ config, lib, pkgs, modulesPath, ... }:

{
  environment.systemPackages = with pkgs; [
    spotify
    discord
    element-desktop
  ];
}
