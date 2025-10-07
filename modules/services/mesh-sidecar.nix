{ config, lib, ... }:
let
  primaryInterface = lib.attrByPath ["networking" "primaryInterface"] null config;
  defaultGatewayInterface = lib.attrByPath ["networking" "defaultGateway" "interface"] null config;
  resolvedOutboundInterface =
    if primaryInterface != null then primaryInterface
    else if defaultGatewayInterface != null then defaultGatewayInterface
    else "eth0";
  meshServices = {
    plexmediaserver.meshName = "plex";
    "docker-ersatztv".meshName = "ersatztv";
    "docker-xteve".meshName = "xteve";
  };
in
{
  config = lib.mkIf config.services.meshSidecar.enable {
    services.meshSidecar = {
      outboundInterface = lib.mkDefault resolvedOutboundInterface;
      services = lib.mkDefault meshServices;
    };
  };
}
