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

  home.file."./.config/nvim/" = { source = ./nvim; recursive = true; };
  home.file."zettelkasten/templates/new_note.md".text = ''
    ---
    title: {{title}}
    date: {{date}}
    ---


  '';

  home.file."zettelkasten/templates/daily.md".text = ''
    ---
    title: {{hdate}}
    ---


  '';

  home.file."zettelkasten/templates/weekly.md".text = ''
    ---
    title: {{year}}-W{{week}}
    date:  {{hdate}}
    ---

    # Review Week {{week}} / {{year}}


  '';


}
