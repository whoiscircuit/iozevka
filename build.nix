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
      rev = "8c6321868a6cf325db6fbb33492a0ec0e869c8bb";
      hash = "sha256-8ne5mD94wwJ7rkEFwfTXQOAWA+zoUq+y0hw3fbxZs44=";
    })
    (fetchzip {
      name = "FontPatcher";
      url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FontPatcher.zip";
      hash = "sha256-JR4sxV2yOXtrnIjFBh4as304BjNIcKkBzxOKLxrjo2I=";
      stripRoot = false;
    })
  ];
  npmDepsHash = "sha256-5DcMV9N16pyQxRaK6RCoeghZqAvM5EY1jftceT/bP+o=";
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
