{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer
      golang.go
      humao.rest-client
      jnoortheen.nix-ide
      eamodio.gitlens
      vadimcn.vscode-lldb
      vscodevim.vim
    ];
    enableUpdateCheck = true;

    userSettings = {
      editor = {
        formatOnSave = true;
      };
      debug = {
        allowBreakpointsEverywhere = true;
      };
      nix = {
        enableLanguageServer = true;
        serverPath = "nil";
        serverSettings = {
          nil = {
            diagnostics = {
              ignored = [ "unused_binding" "unused_with" "unused_rec" ];
            };
            formatting = {
              command = [ "nixpkgs-fmt" ];
            };
          };
        };
      };
      keyboard = {
        dispatch = "keyCode";
      };
      vim = {
        useSystemClipboard = true;
      };
    };
  };
}

