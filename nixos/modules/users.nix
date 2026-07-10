{ pkgs, ... }:

{
	programs.fish.enable = true;
	users.users."humam" = {
		isNormalUser = true;
		shell        = pkgs.fish;
		description  = "humam";
		extraGroups  = [ "networkmanager" "wheel" "docker" ];
		packages     = with pkgs; [];
	};
}
