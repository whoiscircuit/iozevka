# builds the iozevka fonts from source. this might take a long time. if you want to install the font using
# precompiled fonts you can use the iozevka derivation (not iozevka-git) from build.nix
{
  stdenv,
  fetchFromGitHub,
  buildNpmPackage,
  ttfautohint,
  unzip,
  python3,
  fontforge,
  python312Packages,
  nodejs_21,
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
      hash = "sha256-THs6kN5VZpTvzTK7w/sGQbxoEyyPwzl93JDOvwucgeo=";
    })
  ];
  npmDepsHash = "sha256-maDIkbe4BKY7XYOQNGdOalyTGdBXgIU5t0QjVJW6lvQ=";
  sourceRoot = "Iosevka";

  installPhase = ''
    cd ../*-source
    cp * -r ..
    cd ..
    source ./build.sh
  '';

  nativeBuildInputs = [
    ttfautohint
  ];
})
