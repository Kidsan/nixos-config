{ lib,... }:
{
  services.tt-rss = {
    enable = false;
    singleUserMode = true;
    selfUrlPath = "https://rss.home";
  };
  services.nginx.enable = lib.mkForce false;
}
