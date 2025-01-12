{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  rofi-wayland,
  slurp,
  grim,
  ffmpeg,
  wl-screenrec,
  coreutils,
  libnotify,
  hyprland,
  jq,
}:
stdenv.mkDerivation {
  pname = "rofi-screenshot-wayland";
  version = "unstable-2025-01-11";

  src = fetchFromGitHub {
    owner = "wenjinnn";
    repo = "rofi-screenshot-wayland";
    rev = "2a10e816a12b6ce7d4c97823e0388f3cd49adc94";
    sha256 = "sha256-FYtD/x5XqVoKZ3plzDRtjzTb+ouWWtihpBog8lgFWz4=";
  };

  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    runHook preInstall

    install -Dm 0755 rofi-screenshot $out/bin/rofi-screenshot

    wrapProgram $out/bin/rofi-screenshot \
      --prefix PATH ":" ${
      lib.makeBinPath [
        rofi-wayland
        slurp
        grim
        ffmpeg
        wl-screenrec
        coreutils
        libnotify
        hyprland
        jq
      ]
    }

    runHook postInstall
  '';

  meta = with lib; {
    description = "Use rofi and ffcast to perform various types of screenshots and screen captures";
    homepage = "https://github.com/wenjinnn/rofi-screenshot-wayland";
    license = licenses.mit;
    maintainers = with maintainers; [wenjinnn];
    mainProgram = "rofi-screenshot";
    platforms = platforms.linux;
  };
}