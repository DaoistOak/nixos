{
  description = "nixos config flake";
 
  inputs = {
    nixpkgs= {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    zen-browser={
      url = "github:youwen5/zen-browser-flake";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixos-cachyos-kernel = {url = "github:drakon64/nixos-cachyos-kernel";};
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, chaotic, ... }@inputs: {
  nixosConfigurations."Overlord" = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { 
        inherit inputs;
      };
    modules = [
      ./configuration.nix
      home-manager.nixosModules.default
        # chaotic.nixosmodules.nyx-cache
        # chaotic.nixosmodules.nyx-overlay
        # chaotic.nixosmodules.nyx-registry
    ];
  };
};
}
