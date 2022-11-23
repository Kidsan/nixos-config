{ config, lib, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "lobster";
  home.homeDirectory = "/home/lobster";

  home.stateVersion = "20.03";

  home.packages = with pkgs; [

  ];


  programs.git = {
    enable = true;
    userName = "kidsan";
    userEmail = "8798449+Kidsan@users.noreply.github.com";
    ignores = [ "*.nix" "flake.lock" "!personal/**/*.nix" "!personal/**/flake.lock" "!nixos-config/**/*.nix" "!nixos-config/**/flake.lock" ];
    extraConfig = { init = { defaultBranch = "main"; }; pull = { rebase = true; }; };
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimAlias = true;
    extraConfig = ''
      set number

      :map <Up> <Nop>
      :map <Left> <Nop>
      :map <Right> <Nop>
      :map <Down> <Nop>
    '';
    plugins = with pkgs.vimPlugins; [
      vim-nix
      yankring
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
