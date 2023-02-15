{ config, lib, pkgs, ... }:

{

  programs.bash.enable = true;
  programs.bash.bashrcExtra = ''
    export PATH=$PATH:~/go/bin:~/.cargo/bin

    if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
      exec sway
    fi
  '';
  programs.bash.shellAliases = {
    k = "kubectl";
  };

  # programs.bash.sessionVariables = {
  # SSH_AGENT_PID="";
  # SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh";
  # };
}
