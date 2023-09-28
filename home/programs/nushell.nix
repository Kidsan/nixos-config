{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    shellAliases = {
      k = "kubectl";
    };
    envFile = {
      text = ''
        $env.PATH = ($env.PATH | split row (char esep) | append '$env.HOME/.nix-profile/bin')
        $env.PATH = ($env.PATH | split row (char esep) | append '/etc/profiles/per-user/$env.USER/bin')
        $env.PATH = ($env.PATH | split row (char esep) | append '/run/current-system/sw/bin')
        $env.PATH = ($env.PATH | split row (char esep) | append '/nix/var/nix/profiles/default/bin')
        $env.config = {
          show_banner: false,
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
