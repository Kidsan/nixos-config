{ ... }:
{
  programs.tmux = {
    enable = true;
    escapeTime = 10;
    baseIndex = 1;
    clock24 = true;

    keyMode = "vi";
    shell = "/home/kidsan/.nix-profile/bin/nu";
    terminal = "tmux-256color";
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -g default-command "''${SHELL}"
      set -ag terminal-overrides ",*:Tc"
      set-environment -g COLORTERM "truecolor"
      bind C-p previous-window
      bind C-n next-window
    '';
  };

}
