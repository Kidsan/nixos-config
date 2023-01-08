{ config, lib, pkgs, ... }:

{

  programs.bash.enable = true;
  programs.bash.bashrcExtra = ''
    #    export SSH_AGENT_PID="";
    #    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh";
  '';

  # programs.bash.sessionVariables = {
  # SSH_AGENT_PID="";
  # SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh";
  # };
}
