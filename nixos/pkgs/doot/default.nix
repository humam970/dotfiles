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
    rev = version;
    hash = lib.fakeHash;
  };

  vendorHash = lib.fakeHash;

  meta = with lib; {
    description = "Dotfiles manager";
    homepage = "https://github.com/pol-rivero/doot";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "doot";
  };
}
