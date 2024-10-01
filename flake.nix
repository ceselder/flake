{
  description = "flakey wakey";

  inputs = {
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    plymouth-gif-theme.url = "github:toodeluna/plymouth-gif-theme";

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-24.05";
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
        modules = [ 
          ./hosts/celeste-laptop/configuration.nix 
        ];
      };

      nixosConfigurations.celeste-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; system = "x86_64-linux"; };
        modules = [ 
          ./hosts/celeste-desktop/configuration.nix 
        ];
      };
  };
}