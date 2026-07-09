{ config, pkgs, ... }:

{
  imports =
    [
      /etc/hardware-configuration.nix
    ];

	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	time.timeZone = "Asia/Baghdad";
	i18n.defaultLocale = "en_US.UTF-8";

	boot = {
		loader = {
			systemd-boot.enable      = true;
			efi.canTouchEfiVariables = true;
		};

		kernelPackages = pkgs.linuxPackages_latest;
	};

	networking = {
		hostName              = "nixos";
		wireless.enable       = true;
		networkmanager.enable = true;
	};


	services.pulseaudio.enable = false;
	services.pipewire = {
		enable             = true;
		audio.enable       = true;
		alsa.enable        = true;
		alsa.support32Bit  = true;
		pulse.enable       = true;
		jack.enable        = true;
		wireplumber.enable = true;
	  };
	security.rtkit.enable = true;

	programs.fish.enable = true;
	users.users."humam" = {
		isNormalUser = true;
		shell        = pkgs.fish;
		description  = "humam";
		extraGroups  = [ "networkmanager" "wheel" "docker" ];
		packages     = with pkgs; [];
	};

	programs.hyprland = {
		enable           = true;
		xwayland.enable  = true;
		portalPackage    = pkgs.xdg-desktop-portal-hyprland;
	};
	programs.hyprlock.enable  = true;
	programs.hyprpaper.enable = true;
	services.hypridle.enable  = true;
	security.polkit.enable    = true;

	programs.dms-shell = {
		enable = true;

		systemd = {
			enable           = true;
			restartIfChanged = true;
		};
			
		enableVPN = true;
	};
  

	environment.systemPackages = with pkgs; [
		# Extra packages
		bibata-cursors
		ashell
		mako

		# Cli Packages
		fd
		skim
		zellij
		git
		stow
		openvpn3

		# Packages
		fastfetch

		# Utility packages
		pwvucontrol
		brightnessctl
		wl-clipboard

		# TUI packages
		neovim
		yazi
		btop

		# GUI packages
		nautilus
		brave
		ghostty
		rofi

		# Screenshot packages
		grim
		slurp
		satty

		# Dev packages
		go
		gopls
		golangci-lint

		gcc
		clang

		rustup

		lua-language-server

		alejandra
	];

	services.greetd = {
		enable = true;
		settings.default_session.command =
		  "${pkgs.tuigreet}/bin/tuigreet --cmd start-hyprland";
	};

  system.stateVersion = "26.05";
}
