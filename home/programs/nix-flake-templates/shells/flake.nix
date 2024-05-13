{
  outputs = { self }: {

    templates.rust = {
      path = ./rust;
      description = "A simple Rust/Cargo project";
      welcomeText = ''
        Initialized a new Rust flake
      '';
    };

    templates.go = {
      path = ./go;
      description = "A simple Go project";
      welcomeText = ''
        Initialized a new Go flake
      '';
    };

    templates.default = self.templates.rust;
  };
}
