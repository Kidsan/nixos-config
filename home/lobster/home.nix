{ config, lib, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "lobster";
  home.homeDirectory = "/home/lobster";

  home.stateVersion = "20.09";

  home.packages = with pkgs; [

  ];

  programs.git = {
    enable = true;
    userName = "kidsan";
    userEmail = "8798449+Kidsan@users.noreply.github.com";
    ignores = [ "*.nix" "flake.lock" "!personal/**/*.nix" "!personal/**/flake.lock" "!nixos-config/**/*.nix" "!nixos-config/**/flake.lock" ];
    extraConfig = { init = { defaultBranch = "main"; }; pull = { rebase = true; }; };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
