{
  description = "flakey wakey";

  inputs = {
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
  };

  outputs = { nixpkgs,... } @ inputs: {
    nixosConfigurations.celeste-laptop = nixpkgs.lib.nixosSystem {
     system = "x86_64-linux";
     specialArgs = { inherit inputs; system = "x86_64-linux"; };
     modules = [ ./hosts/celeste-laptop/configuration.nix ];
    }; 
  };
}
