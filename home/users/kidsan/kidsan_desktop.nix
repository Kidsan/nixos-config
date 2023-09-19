{ config, lib, pkgs, ... }:

{
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    audacity
    kord
    transcribe
  ];

  imports = [
    ./common.nix
    ../../programs/easyeffects.nix
    #    ../../programs/i3.nix
  ];

  home.persistence."/persist/home/kidsan" = {
    allowOther = true;
    directories = [
      ".local/share/keyrings"
      ".local/share/direnv"
      ".ssh"
      "workspace"
      "nixos-config"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
  };


}
