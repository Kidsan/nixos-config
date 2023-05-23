{ pkgs, ... }:
{
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
}
