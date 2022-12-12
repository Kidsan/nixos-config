let
  kidsanThinkpad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKas9qjJOceFVG6IS3LgH1RL0EBNZ66LFeLrsOqT31IL";
  lobsterMonster = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFIIjC0jPPm97QPnB5vJi3k4l1B9SVl13u/CV2KoYqrD";
  users = [ kidsanThinkpad lobsterMonster ];

  thinkpad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMdwwNmNX3e4ZNAUyuPWJcHkYCS03dPA1DexNJtKPgP4";
  monster = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIFtqmq5ozAZcaMj5k1Jc64abBLC4h/czURw8sEYlWYD";
  systems = [ thinkpad monster ];
in
{
  foo = {
    secret = {
      publicKeys = [ kidsanThinkpad ]; # recipients in age terms
      file = ./foo/foo.age;
    };
  };

  znc = {
    secret = {
      publicKeys = [ kidsanThinkpad monster ];
      file = ./znc/znc.conf.age;
    };
  };

  unbound = {
    secret = {
      file = ./unbound/unbound.conf.age;
      publicKeys = [ thinkpad monster ];
    };
  };

}
