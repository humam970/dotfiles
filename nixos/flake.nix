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
	pkgs          = import nixpkgs { inherit system; };
	commonModules = [
		stylix.nixosModules.stylix
		./configuration.nix
	];
  in {
	packages.${system}.doot = pkgs.callPackage ./pkgs/doot { };

    nixosConfigurations = {
		home = lib.nixosSystem {
			inherit system;

			specialArgs = {
				inherit self;
			};

			modules = commonModules ++ [
				./hardware/home-machine.nix
			];
		};

		work = lib.nixosSystem {
			inherit system;

			specialArgs = {
				inherit self;
			};

			modules = commonModules ++ [
				# ./hardware/work-machine.nix
			];
		};
    };
  };
}
