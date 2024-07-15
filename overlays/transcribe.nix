self: super: {
  transcribe = super.transcribe.overrideAttrs {
    version = "9.41.2";
    src = super.fetchzip
      {
        url = "https://www.seventhstring.com/xscribe/downlo/xscsetup-9.41.2.tar.gz";
        sha256 = "sha256-VWfjtNbwK9ZiWgs161ubRy+IjSXXk3FEfMkmA6Jhz8A=";
      };
  };
}

