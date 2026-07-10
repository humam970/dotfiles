{
	lib,
	buildGoModule,
	fetchFromGitHub,
	...
}:

buildGoModule rec {
  pname = "doot";
  version = "0.6.8";

  src = fetchFromGitHub {
    owner = "pol-rivero";
    repo = "doot";
    rev = "v${version}";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  vendorHash = "sha256-9h1EeNREmumRsaNHjD+NHkQtApiZuQZW/xj9lfRcQtE=";

  meta = with lib; {
    description = "Dotfiles manager";
    homepage = "https://github.com/pol-rivero/doot";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "doot";
  };
}
