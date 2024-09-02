{
  description = "flakey wakey";

  inputs = {
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.celeste-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; system = "x86_64-linux"; };
        modules = [ ./hosts/celeste-laptop/configuration.nix ];
      }; 

      homeConfigurations."celeste-laptop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home.nix ];
      };
    }
    ;
}

