{ config, pkgs, lib, ... }:
let
  server = "100.99.106.71";
  shareOptions = [ "x-systemd.automount" "noauto" "_netdev" "x-systemd.idle-timeout=600" ];
  shares = {
    "/tv" = "/mnt/main_pool/media/tv";
    "/movies" = "/mnt/main_pool/media/movies";
  };
  mkFileSystem = mountPoint: remotePath: {
    name = mountPoint;
    value = {
      device = "${server}:${remotePath}";
      fsType = "nfs";
      options = shareOptions;
    };
  };
  fileSystems = lib.mapAttrs' mkFileSystem shares;
in
{
  inherit fileSystems;

  systemd.tmpfiles.rules = [
    "d /var/lib/ersatztv 0755 root root -"
    "d /var/lib/xteve     0755 root root -"
    "d /tmp/xteve         0755 root root -"
  ];
}
