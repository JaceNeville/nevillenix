{
  description = "Jace's NixOS with Flakes + containerized services";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      modules = {
        base = import ./modules/base.nix;
        networking = import ./modules/networking.nix;
        docker = import ./modules/docker.nix;
        nfs = import ./modules/nfs.nix;
        services = import ./modules/services;
        default = import ./modules/default.nix;
      };
    in {
      inherit modules;
      nixosModules = modules;

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/nixos/configuration.nix
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}
