{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations."Overlord" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };  # Pass inputs here
      modules = [
        ./configuration.nix
        home-manager.nixosModules.default
      ];
    };
  };
}

