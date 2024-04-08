{ pkgs, ... }:

{
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    wttrbar
  ];

  imports = [
    ./common.nix
    ../../programs/sway.nix
    ../../programs/easyeffects.nix
  ];

  programs.ncspot = {
    enable = true;
    settings = {
      shuffle = true;
      gapless = true;
    };
  };
}
