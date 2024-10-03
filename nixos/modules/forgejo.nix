{ pkgs, inputs, ... }: {

  services.forgejo = {
    enable = true;
    package = inputs.nixpkgs.legacyPackages.${pkgs.system}.forgejo;
    settings = {
      server.ROOT_URL = "https://git.home";
      server.DOMAIN = "git.home";
      server.SSH_PORT = 22;
      server.HTTP_PORT = 3333;
    };
  };

  services.gitea-actions-runner = {
    package = pkgs.forgejo-runner;
    instances = {
      test = {
        enable = true;
        token = "KBxpGnOLRY9uH0yFRKLgEl5wnJIKg6aYCLzUtonV";
        url = "http://192.168.2.175:3333";
        name = "local";
        labels = [
          # provide a debian base with nodejs for actions
          "debian-latest:docker://node:18-bullseye"
          # fake the ubuntu name, because node provides no ubuntu builds
          "ubuntu-latest:docker://node:18-bullseye"
          # provide native execution on the host
          #"native:host"
        ];
      };
    };
  };

}
