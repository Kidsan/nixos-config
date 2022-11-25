{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = [
      pkgs.vscode-extensions.rust-lang.rust-analyzer
      pkgs.vscode-extensions.golang.go
      pkgs.vscode-extensions.humao.rest-client
      pkgs.vscode-extensions.jnoortheen.nix-ide
      pkgs.vscode-extensions.eamodio.gitlens
    ];
    enableUpdateCheck = false;

    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "editor.formatOnSave" = true;
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
