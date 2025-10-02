{ config, pkgs, ... }:
{
  users.users.nevillecasaadmin = {
    isNormalUser = true;
    description = "Jace Neville";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    # If you want to match PUID=1000 inside containers, uncomment:
    # uid = 1000;
  };
}
