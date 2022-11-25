{ config, lib, pkgs, ... }:

{
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
}
