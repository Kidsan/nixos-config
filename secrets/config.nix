let
  kidsanThinkpad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKas9qjJOceFVG6IS3LgH1RL0EBNZ66LFeLrsOqT31IL";
  lobsterMonster = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMuW2Mi0u4NqXtTr4FSzN9b/qh5UlMGbo+JcqCqCfoP4 lobster@monster";
  users = [ kidsanThinkpad lobsterMonster ];

  thinkpad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMdwwNmNX3e4ZNAUyuPWJcHkYCS03dPA1DexNJtKPgP4";
  monster = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILP795O0lhtd8WX+7Nnw0i4hpykl9bPFsENwuzGVZ6Js";
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

  adguard = {
    secret = {
      file = ./adguard/AdGuardHome.yml.age;
      publicKeys = [ thinkpad monster kidsanThinkpad ];
    };
  };

  wpa_supplicant = {
    secret = {
      file = ./wpa_supplicant/wpa_supplicant.conf.age;
      publicKeys = [ thinkpad monster kidsanThinkpad ];
    };
  };

  zwavejs_ui_settings = {
    secret = {
      file = ./zwavejs_ui/zwavejs_ui_settings.json.age;
      publicKeys = [ kidsanThinkpad monster ];
    };
  };

  zwavejs_ui_nodes = {
    secret =
      {
        file = ./zwavejs_ui/zwavejs_ui_nodes.json.age;
        publicKeys = [ kidsanThinkpad monster ];
      };
  };
}
