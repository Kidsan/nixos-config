{ self, ... }:
{
  "firefox-nightly" = import "./firefox-nightly.nix";
  "weechat" = import "./weechat.nix";
}
