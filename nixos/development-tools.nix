{ config, lib, pkgs, modulesPath, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neovim-nightly
    direnv
  ];
}
