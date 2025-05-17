{
  description = "iozevka";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    mkIozevka = {variant,hash}: pkgs.stdenvNoCC.mkDerivation rec {
      pname = "iozevka-${variant}";
      version = "1.2";
      propagatedUserEnvPkgs = [];
      src = pkgs.fetchzip {
        url = "https://github.com/oxcl/iozevka/releases/download/v${version}/iozevka-${variant}.zip";
        hash = "";
      };
      installPhase = ''
        runHook preInstall
        find . -name '*.ttf' -exec install -m444 -Dt $out/share/fonts/truetype {} \;
        runHook postInstall
      '';
    };
    iozevka = mkIozevka {variant = "all"; hash = "";};
    iozevka-code = mkIozevka {variant = "code"; hash = "";};
    iozevka-nerd = mkIozevka {variant = "nerd"; hash = "";};
    iozevka-mono = mkIozevka {variant = "mono"; hash = "";};
    iozevka-term = mkIozevka {variant = "term"; hash = "";};
    iozevka-quasi = mkIozevka {variant = "quasi"; hash = "";};
    iozevka-slabs = mkIozevka {variant = "slabs"; hash = "";};
    iozevka-git = import ./build.nix pkgs;
  in {
    packages.${system} = {
      inherit iozevka iozevka-git iozevka-nerd iozevka-code iozevka-quasi iozevka-slabs iozevka-term iozevka-mono;
      default = iozevka;
    };
    overlays.default = final: prev: {
      inherit iozevka iozevka-nerd iozevka-code iozevka-quasi iozevka-slabs iozevka-term iozevka-mono;
    };
  };
}
