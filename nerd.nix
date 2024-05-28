# this derivation is for installing the iozevka with nerd fonts patch from the precompiled fonts that are avaiable on the
# github releases of the iozevka repository (github.com/oxcl/iozevka)
# this does not build the fonts from source for that you should use the iozevka-git derivation from build.nix
# if you want the normal version of the fonts without the nerd icons you should use the iozevka package from default.nix
{pkgs ? import <nixpkgs> {}, ...}: with pkgs; stdenvNoCC.mkDerivation rec {
  pname = "iozevka-nerd";
  version = "0.0.1";
  propagatedUserEnvPkgs = [];
  src = fetchzip {
    url = "https://github.com/oxcl/iozevka/releases/download/stable/iozevka-nerd.zip";
    hash = "sha256-62ynwEhQXnNPMtyhS0WJzjPURcTqiI+6n2GhRkYkcdg=";
  };
  installPhase = ''
    runHook preInstall
    find . -name '*.ttf' -exec install -m444 -Dt $out/share/fonts/truetype {} \;
    runHook postInstall
  '';
}
