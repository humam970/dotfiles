{ pkgs, ... }:

{
	programs.hyprland = {
		enable           = true;
		xwayland.enable  = true;
		portalPackage    = pkgs.xdg-desktop-portal-hyprland;
	};
	programs.hyprlock.enable  = true;
	services.hypridle.enable  = true;
	security.polkit.enable    = true;

	environment.systemPackages = with pkgs; [
		hyprpaper
		hyprsunset
	];

	services.greetd = {
		enable = true;
		settings.default_session.command =
		  "${pkgs.tuigreet}/bin/tuigreet --cmd start-hyprland";
	};
}
