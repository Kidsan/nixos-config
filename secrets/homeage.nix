let
  age = {
    system = {
      thinkpad = {
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKas9qjJOceFVG6IS3LgH1RL0EBNZ66LFeLrsOqT31IL";
        privateKeyPath = "~/.ssh/id_ed25519"; # for identity path config
      };
    };
  };
in
{
  inherit age;

  foo = {
    secret = {
      publicKeys = with (age.system); [ thinkpad.publicKey ];
      file = ./foo/foo.age;
    };
  };


}
