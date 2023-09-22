{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableNushellIntegration = true;
    settings = {
      add_newline = true;
      character.success_symbol = "[➜](bold green)";
      package.disabled = true;
      nix_shell = {
        format = "[$symbol]($style)";
      };
      rust = { };
      golang = { format = "[$symbol($version )]($style)"; };
      format = "$username$directory$git_branch$golang$rust$nix_shell$character";
    };
  };
}
