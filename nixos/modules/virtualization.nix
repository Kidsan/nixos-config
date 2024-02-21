{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    win-virtio
    win-spice
  ];

  users.users."kidsan".extraGroups = [ "libvirtd" ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
      };
    };
  };
}
