{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
	lib    = nixpkgs.lib;
  in {
    nixosConfigurations = {
      inherit system;
      humam = lib.nixosSystem {
        modules = [
			./configuration.nix
		];
      };
    };
  };
}
