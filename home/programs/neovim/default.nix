{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep
    fd
    lua-language-server
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimAlias = true;
    coc.enable = false;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];
  };

  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };

  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  };

}
