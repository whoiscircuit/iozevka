# builds the iozevka fonts from source. this might take a long time. if you want to install the font using
# precompiled fonts you can use the iozevka derivation (not iozevka-git) from build.nix
{
  stdenv,
  fetchFromGitHub,
  fetchzip,
  buildNpmPackage,
  ttfautohint,
  unzip,
  zip,
  python3,
  fontforge,
  python310Packages,
  ...
}:
(buildNpmPackage rec {
  pname = "iozevka";
  version = "1.2";
  srcs = [
    ./.
    (fetchFromGitHub {
      owner = "be5invis";
      repo = "Iosevka";
      name = "Iosevka";
      rev = "931ea8d6c688c1d57a425050f762d0151f19d29b";
      hash = "sha256-GGtbW4Y/02ubdufTXmywGS4jyMfm8RfOMvmUNoUcLQg=";
    })
    (fetchzip {
      name = "FontPatcher";
      url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FontPatcher.zip";
      hash = "sha256-3s0vcRiNA/pQrViYMwU2nnkLUNUcqXja/jTWO49x3BU=";
      stripRoot = false;
    })
  ];
  npmDepsHash = "sha256-/zLWtIIPNOMrICKaj5SY1Bo3Pdso6a776fIYY/7X0U4=";
  sourceRoot = "Iosevka";

  installPhase = ''
    cd ../*-source
    cp -r * ..
    cd ..
    source ./build.sh
    mkdir -p $out
    cp ./out/*.zip $out
  '';

  nativeBuildInputs = [
    ttfautohint
    python3
    python310Packages.fontforge
    unzip
    zip
  ];
})
