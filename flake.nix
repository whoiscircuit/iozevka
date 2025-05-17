{
  description = "iozevka";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    mkIozevka = {variant,hash,filename}: pkgs.stdenvNoCC.mkDerivation rec {
      pname = "iozevka-${variant}";
      version = "1.2";
      propagatedUserEnvPkgs = [];
      src = pkgs.fetchzip {
        inherit hash;
        url = "https://github.com/whoiscircuit/iozevka/releases/download/v${version}/${filename}.zip";
      };
      installPhase = ''
        runHook preInstall
        find . -name '*.ttf' -exec install -m444 -Dt $out/share/fonts/truetype {} \;
        runHook postInstall
      '';
    };
    iozevka-code  = mkIozevka {variant = "code" ; filename="IoZevkaCode"; hash = "sha256-vrMW9nDTT0z+R5IezKm/xPLRDNEX32nW67jGirBg3pM=";};
    iozevka-nerd  = mkIozevka {variant = "nerd" ; filename="IoZevkaNerd"; hash = "sha256-edCXj5/d+fqJBGTZDHFiGFuy7XJdPtu/AnyD1MbkFZU=";};
    iozevka-mono  = mkIozevka {variant = "mono" ; filename="IoZevkaMono"; hash = "sha256-LVvbMqqQ1qEQ8XPrWLR5FD1tuIyB2s4Rub1BWqcWqus=";};
    iozevka-term  = mkIozevka {variant = "term" ; filename="IoZevkaTerm"; hash = "sha256-CUbnufQbF4ayiXTLmXUAKNJhFzlr2WqFzcdzhx8zR3s=";};
    iozevka-quasi = mkIozevka {variant = "quasi"; filename="IoZevkaQuasi"; hash = "sha256-l6AfaEskceFFR83RirxfmaVuy/nfKeCcmCKwmo/glCQ=";};
    iozevka-slabs = mkIozevka {variant = "slabs"; filename="IoZevkaSlabs"; hash = "sha256-LyeRWe1SIto6lBjhhJdFEVD1EwbLY1UcqDclwQjUM5c=";};
    iozevka-git = import ./build.nix pkgs;
  in {
    packages.${system} = {
      inherit iozevka-git iozevka-nerd iozevka-code iozevka-quasi iozevka-slabs iozevka-term iozevka-mono;
    };
    overlays.default = final: prev: {
      inherit iozevka-nerd iozevka-code iozevka-quasi iozevka-slabs iozevka-term iozevka-mono;
    };
  };
}
