{ config, lib, pkgs, ... }:

{
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    discordo
    vim
    curl
    git
    btop
  ];

  imports = [
    ../programs/git.nix
    ../programs/tmux.nix
    ../programs/nushell.nix
    ../programs/neovim
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.activation.report-changes = config.lib.dag.entryAnywhere ''
    ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff $oldGenPath $newGenPath
  '';

  home.username = "kidsan";
  home.homeDirectory = "/home/kidsan";

  home.sessionVariables = {
    EDITOR = "nvim";
    NIX_PATH = "nixpkgs=flake:nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
  };

  # restart homeage decrypt services on home-manager change
  systemd.user.startServices = "sd-switch";


}
