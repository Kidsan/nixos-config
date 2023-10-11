{ config, lib, pkgs, ... }:

{
  home.stateVersion = "22.11";
  home.sessionVariables.NIX_PATH = "nixpkgs=flake:nixpkgs$\{NIX_PATH:+:$NIX+PATH}";

  imports = [
    ./common.nix
    ../../programs/sway.nix
    ../../programs/nushell.nix
  ];
}
