{ ... }:
{
  imports = [
    ../hosts/nixos/hardware-configuration.nix
    ./base.nix
    ./networking.nix
    ./docker.nix
    ./nfs.nix
    ./meshSidecar.nix
    ./services
    ../users/jace.nix
  ];
}
