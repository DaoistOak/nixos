{
  description = "Nixos config flake";
 
  inputs = {
    nixpkgs= {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixos-cachyos-kernel = {url = "github:drakon64/nixos-cachyos-kernel";};
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, home-manager, chaotic, ... }@inputs: {
    nixosConfigurations."Overlord" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };  # Pass inputs here
      modules = [
        ./configuration.nix
        home-manager.nixosModules.default
        chaotic.nixosModules.nyx-cache
        chaotic.nixosModules.nyx-overlay
        chaotic.nixosModules.nyx-registry
        # nixos-cachyos-kernel.nixosModules.default  # Add CachyOS kernel module
      ];
    };
  };
}

