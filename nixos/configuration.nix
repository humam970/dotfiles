{ self, config, pkgs, ... }:

{
  imports =
    [
	  ./modules
    ];

	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	time.timeZone = "Asia/Baghdad";
	i18n.defaultLocale = "en_US.UTF-8";

	environment.systemPackages = with pkgs; [
		# Extra Packages
		bibata-cursors
		fastfetch
		ashell

		# Cli Packages
		libnotify
		tree-sitter
		bat
		ripgrep
		fd
		fzf
		skim
		zellij
		git
		stow
		openvpn3
		eza
		self.packages.${pkgs.system}.doot

		# Utility Packages
		pwvucontrol
		brightnessctl
		wl-clipboard

		# TUI Packages
		neovim
		yazi
		btop

		# GUI Packages
		nautilus
		brave
		ghostty
		rofi

		# Screenshot Packages
		grim
		slurp
		satty

		# Dev Packages
		go
		gopls
		golangci-lint
		golangci-lint-langserver

		gcc
		clang

		rustup

		lua-language-server
		stylua

		alejandra
	];

	hardware.bluetooth.enable = true;
	services.blueman.enable   = true;
	services.upower.enable    = true;

	# Remove Bloat
	programs.nano.enable = false;

	system.stateVersion = "26.05";
}
