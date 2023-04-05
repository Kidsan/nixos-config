{ config, lib, pkgs, ... }:

{

  programs.fzf.enable = true;
  programs.bash.enable = true;
  programs.bash.bashrcExtra = ''
    export PATH=$PATH:~/go/bin:~/.cargo/bin
    parse_git_branch() {
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\[(\1)\]/'
    }
    export PS1="\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\[\033[33m\]\$(parse_git_branch)\[\033[1;32m\]\$\[\033[0m\] "
  '';
  programs.bash.shellAliases = {
    k = "kubectl";
  };

  # programs.bash.sessionVariables = {
  # SSH_AGENT_PID="";
  # SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh";
  # };
}
