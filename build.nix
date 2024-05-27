# builds the iozevka fonts from source. this might take a long time. if you want to install the font using
# precompiled fonts you can use the iozevka derivation (not iozevka-git) from build.nix
{
  stdenv,
  fetchFromGitHub,
  fetchzip,
  buildNpmPackage,
  ttfautohint,
  unzip,
  python3,
  fontforge,
  python310Packages,
  ...
}:
(buildNpmPackage rec {
  name = "iozevka";
  srcs = [
    ./.
    (fetchFromGitHub {
      owner = "be5invis";
      repo = "Iosevka";
      name = "Iosevka";
      rev = "29956e2ef7cd6e6f7ca600405c4c4968340b67c5";
      hash = "sha256-PVPr/mI13UDJfXy+vmj3DfZ1vkcE7r7YoWTeXokJz50=";
    })
    (fetchzip {
      name = "FontPatcher";
      url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FontPatcher.zip";
      hash = "sha256-3s0vcRiNA/pQrViYMwU2nnkLUNUcqXja/jTWO49x3BU=";
      stripRoot = false;
    })
  ];
  npmDepsHash = "sha256-/MWONDfq+2TqwcOJFnjLatSdGvMqcgMjJnuuAduWJ14=";
  sourceRoot = "Iosevka";

  installPhase = ''
    cd ../*-source
    cp * -r ..
    cd ..
    source ./build.sh
    mkdir -p $out
    cp ./out/* $out
  '';

  nativeBuildInputs = [
    ttfautohint
    python3
    unzip
    #fontforge
    python310Packages.fontforge
  ];
})
