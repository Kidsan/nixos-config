self: super: {
 vimPlugins = super.vimPlugins.extend (self': super': {
   nvim-treesitter = super'.nvim-treesitter.overrideAttrs (old: {
     version = "nightly";
     src = super.fetchFromGitHub {
       owner = "nvim-treesitter";
       repo = "nvim-treesitter";
       rev = "e1e3108cd23d7f967842261bd66126b6734d8907";
       sha256 = "sha256-XwVT04ZLuAIsR+l0HlZm9lFMiWsdwgkvaTdJNk78UGc=";
     };
   });
 });
}

