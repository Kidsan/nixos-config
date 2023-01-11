{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimAlias = true;
    coc.enable = false;

    plugins = with pkgs.vimPlugins; [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };

  home.file."./.config/nvim/" = { source = ./nvim; recursive = true; };
}
