{ config, pkgs, lib, ... }:
{
  virtualisation.oci-containers.containers.xteve = {
    image = "alturismo/xteve:latest";
    autoStart = true;
    ports = [ "8409:34400" ];
    volumes = [
      "/var/lib/xteve:/root/.xteve:rw"
      "/tmp/xteve:/tmp/xteve:rw"
    ];
    environment = {
      TZ = config.time.timeZone;
    };
  };
}
