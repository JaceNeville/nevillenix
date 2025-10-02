{ config, pkgs, ... }:
{
  fileSystems."/tv" = {
    device = "100.99.106.71:/mnt/main_pool/media/tv";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "_netdev" "x-systemd.idle-timeout=600" ];
  };

  fileSystems."/movies" = {
    device = "100.99.106.71:/mnt/main_pool/media/movies";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "_netdev" "x-systemd.idle-timeout=600" ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/ersatztv 0755 root root -"
    "d /var/lib/xteve     0755 root root -"
    "d /tmp/xteve         0755 root root -"
  ];
}
