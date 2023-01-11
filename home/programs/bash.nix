{ config, lib, pkgs, ... }:

{

  programs.bash.enable = true;
  programs.bash.bashrcExtra = ''
    export PATH=$PATH:~/go/bin:~/.cargo/bin
  '';

  # programs.bash.sessionVariables = {
  # SSH_AGENT_PID="";
  # SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh";
  # };
}
