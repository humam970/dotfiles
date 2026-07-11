{ config, pkgs, ... }:

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

	programs.nano.enable    = false;
	programs.fish.enable    = true;

	environment.systemPackages = with pkgs; [
		mesa
		# Extra Packages
		base16-schemes
		fishPlugins.pure
		bibata-cursors
		fastfetch
		mako
		swayosd
		quickshell
		adwaita-icon-theme
		adwaita-fonts
		adwaita-qt6
		adwaita-qt

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
		openvpn3
		eza
		cloc

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

	hardware.bluetooth.enable             = true;
	services.blueman.enable               = true;
	services.upower.enable                = true;
	services.power-profiles-daemon.enable = true;

	system.stateVersion = "26.05";
}
