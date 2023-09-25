{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    envFile = {
      text = ''
        $env.config = {
          cursor_shape: {
            emacs: inherit # block, underscore, line (line is the default)
            vi_insert: inherit # block, underscore, line (block is the default)
            vi_normal: inherit # block, underscore, line  (underscore is the default)
          }
        };
      '';
    };
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
