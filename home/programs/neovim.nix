{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimAlias = true;
    coc.enable = true;
    coc.settings = {
      coc.preferences = {
        formatOnSaveFiletypes = [
          "nix"
        ];
      };
      languageserver = {
        go = {
          command = "gopls";
          rootPatterns = [ "go.mod" ];
          filetypes = [ "go" ];
        };
        nix = {
          command = "nil";
          filetypes = [ "nix" ];
          rootPatterns = [ "flake.nix" ];
          settings = {
            nil.formatting = {
              command = [ "nixpkgs-fmt" ];
            };
          };
        };
      };
    };
    extraConfig = ''
      let mapleader=','
      set number
      set autoindent
      set ruler
      set hlsearch
      set autowrite
      syntax on
      set colorcolumn=120

      :map <Up> <Nop>
      :map <Left> <Nop>
      :map <Right> <Nop>
      :map <Down> <Nop>



      map <C-n> :cnext<CR>
      map <C-m> :cprevious<CR>
      nnoremap <leader>a :cclose<CR>

      " autocmd FileType go nmap <leader>b  <Plug>(go-build)
      autocmd FileType go nmap <leader>r  <Plug>(go-run) 

      let g:go_list_type = "quickfix"
      autocmd FileType go nmap <leader>t  <Plug>(go-test)

      " run :GoBuild or :GoTestCompile based on the go file
      function! s:build_go_files()
        let l:file = expand('%')
        if l:file =~# '^\f\+_test\.go$'
          call go#test#Test(0, 1)
        elseif l:file =~# '^\f\+\.go$'
          call go#cmd#Build(0)
        endif
      endfunction

      autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
      autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
      let g:go_fmt_command = "goimports"
      let g:go_highlight_types = 1
      let g:go_highlight_fields = 1
      let g:go_highlight_functions = 1
      let g:go_highlight_function_calls = 1
      let g:go_highlight_operators = 1
      let g:go_highlight_extra_types = 1
      let g:go_highlight_build_constraints = 1
      let g:go_highlight_generate_tags = 1
      autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
      let g:go_metalinter_autosave = 1
      let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
      let g:go_metalinter_deadline = "5s"

      autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
      autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
      autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
      autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
      inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"


    '';

    plugins = with pkgs.vimPlugins; [
      vim-nix
      yankring
      vim-gitgutter
      vim-commentary
      vim-go
      splitjoin-vim
      ultisnips
      ctrlp-vim
    ];
  };
}
