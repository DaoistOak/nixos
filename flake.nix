{
  description = "Nixos config flake";
 
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cachyos-kernel = {
      url = "github:drakon64/nixos-cachyos-kernel";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-cachyos-kernel, ... }@inputs: {
    nixosConfigurations."Overlord" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };  # Pass inputs here
      modules = [
        ./configuration.nix
        home-manager.nixosModules.default
        nixos-cachyos-kernel.nixosModules.default  # Add CachyOS kernel module
      ];
    };
  };
}

