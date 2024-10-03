{...}: {

  virtualisation.oci-containers = {
    containers.isponsorblock = {
      volumes = [ "/etc/sponsorblocktv:/app/data" ];
      image = "ghcr.io/dmunozv04/isponsorblocktv:latest";
      ports = [ ];
      autoStart = true;
      extraOptions = [
        "--net=host"
      ];
    };
  };
}
