{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimAlias = true;
    coc.enable = false;

    plugins = with pkgs.vimPlugins; [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };
}
