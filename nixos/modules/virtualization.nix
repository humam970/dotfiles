{ pkgs, ... }:

{
	virtualisation = {
		docker.enable = true;

		# libvirtd = {
		# 		enable = true;
		# 		qemu.runAsRoot = false;
		# };

		waydroid = {
			enable = true;
			package = pkgs.waydroid-nftables;
		};
	};

    environment.systemPackages = with pkgs; [
		docker
		docker-compose
		lazydocker
		virt-manager
	];
}
