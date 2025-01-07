{
  runCommandNoCC,
  lib,
  makeWrapper,
  hyprland,
  hyprpaper,
  gawk,
  bash,
  coreutils-full,
  findutils,
}:
runCommandNoCC "wallpaper-switch" {
  nativeBuildInputs = [makeWrapper];
} ''
  mkdir -p $out/bin
  dest="$out/bin/wallpaper-switch"
  cp ${./wallpaper-switch.sh} $dest
  chmod +x $dest
  patchShebangs $dest

  wrapProgram $dest \
    --prefix PATH : ${lib.makeBinPath [hyprland hyprpaper gawk findutils coreutils-full bash]}
''