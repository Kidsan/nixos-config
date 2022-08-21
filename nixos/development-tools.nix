{ config, lib, pkgs, modulesPath, ... }:

{
  environment.systemPackages = with pkgs; [ 
    git
    vscodium
    neovim
    direnv
  ];
}
