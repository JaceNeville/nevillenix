{ config, pkgs, lib, ... }:
{
  virtualisation.oci-containers.containers.ersatztv = {
    image = "jasongdove/ersatztv:latest";
    autoStart = true;
    ports = [ "34400:34400" ];
    volumes = [
      "/var/lib/ersatztv:/root/.local/share/ersatztv"
      "/movies:/movies:ro"
      "/tv:/tv:ro"
    ];
    environment = {
      TZ = "America/Chicago";
      PUID = "1000";
      PGID = "1000";
    };
  };
}
