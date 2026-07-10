{
  description = "NixOS Configuration";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		stylix = {
			url = "github:nix-community/stylix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

  outputs = {
    self,
    nixpkgs,
	stylix,
    ...
  } @ inputs: let
    system        = "x86_64-linux";
	lib           = nixpkgs.lib;
	commonModules = [
		stylix.nixosModules.stylix
		./configuration.nix
	];
  in {
    nixosConfigurations = {
      home = lib.nixosSystem {
		inherit system;
		modules = commonModules ++ [
			./hardware/home-machine.nix
		];
      };

	  work = lib.nixosSystem {
		inherit system;
		modules = commonModules ++ [
			# ./hardware/work-machine.nix
		];
      };
    };
  };
}
