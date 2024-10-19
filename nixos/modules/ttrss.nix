{ lib,... }:
{
  services.tt-rss = {
    enable = true;
    singleUserMode = true;
    selfUrlPath = "https://rss.home";
  };
  services.nginx.enable = lib.mkForce false;
}
