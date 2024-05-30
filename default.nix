# this derivation is for installing the iozevka fonts from the precompiled fonts that are avaiable on the
# github releases of the iozevka repository (github.com/oxcl/iozevka)
# this does not build the fonts from source for that you should use the iozevka-git derivation from build.nix
{pkgs ? import <nixpkgs> {}, ...}: with pkgs; stdenvNoCC.mkDerivation rec {
  pname = "iozevka";
  version = "1.1";
  propagatedUserEnvPkgs = [];
  src = fetchzip {
    url = "https://github.com/oxcl/iozevka/releases/download/stable/iozevka-ttf.zip";
    hash = "sha256-Aug+s4p5okCE+GtCfpEh3nioXcZ69oaesZTDyqeB0ig=";
  };
  installPhase = ''
    runHook preInstall
    find . -name '*.ttf' -exec install -m444 -Dt $out/share/fonts/truetype {} \;
    runHook postInstall
  '';
}
