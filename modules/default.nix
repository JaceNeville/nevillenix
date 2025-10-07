{ ... }:
{
  imports = [
    ../hosts/nixos/hardware-configuration.nix
    ./base.nix
    ./networking.nix
    ./docker.nix
    ./nfs.nix
    ./services
    ../users/jace.nix
  ];
}
