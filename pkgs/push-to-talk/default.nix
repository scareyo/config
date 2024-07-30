{ fetchFromGitHub, lib, libevdev, pkg-config, stdenv, xdotool, xorg }:

stdenv.mkDerivation {
  name = "push-to-talk";

  src = fetchFromGitHub {
    owner = "Rush";
    repo = "wayland-push-to-talk-fix";
    rev = "490f43054453871fe18e7d7e9041cfbd0f1d9b7d";
    sha256 = "11zbqz9zznzncf84jrvd5hl2iig6i1cpx6pwv02x2dg706ns0535";
  };

  nativeBuildInputs = [
    libevdev
    pkg-config
    xdotool
    xorg.libX11.dev
  ];

  installPhase = ''
    mkdir -p $out/bin
    install -m 755 push-to-talk $out/bin
  '';
}
