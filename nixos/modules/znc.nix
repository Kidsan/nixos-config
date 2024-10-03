{...}: {

  services.znc = {
    enable = true;
    mutable = true;
    useLegacyConfig = false;
    openFirewall = true;
    confOptions.useSSL = false;
  };
}

