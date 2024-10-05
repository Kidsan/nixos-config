{config,...}: {

  services.znc = {
    enable = true;
    mutable = true;
    useLegacyConfig = false;
    openFirewall = true;
    confOptions.useSSL = false;
    configFile = config.age.secrets.znc.path;
  };
}

