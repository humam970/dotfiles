{
	lib,
	buildGoModule,
	fetchFromGitHub,
	...
}:

buildGoModule rec {
	pname = "doot";
	version = "0.6.8";
	vendorHash = "sha256-9h1EeNREmumRsaNHjD+NHkQtApiZuQZW/xj9lfRcQtE=";
	doCheck = false;

	src = fetchFromGitHub {
		owner = "pol-rivero";
		repo = "doot";
		rev = version;
		hash = "sha256-NZnga6KRYaBGgIoKGwskyy1jGYjT0qoMSQ6jh1Cjf5A=";
	};

	meta = with lib; {
		description = "Dotfiles manager";
		homepage = "https://github.com/pol-rivero/doot";
		license = licenses.mit;
		platforms = platforms.linux;
		mainProgram = "doot";
	};
}
