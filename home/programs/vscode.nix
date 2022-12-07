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
    ];
    enableUpdateCheck = true;

    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "editor.formatOnSave" = true;
      "debug.allowBreakpointsEverywhere" = true;
      "nix.serverSettings" = {
        "nil" = {
          "diagnostics" = {
            "ignored" = [
              "unused_binding"
              "unused_with"
              "unused_rec"
            ];
          };
          "formatting" = {
            "command" = [
              "nixpkgs-fmt"
            ];
          };
        };
      };
    };
  };
}
