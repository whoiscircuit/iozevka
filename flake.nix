{
  description = "iozevka";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-22.11";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    iozevka-git = import ./build.nix pkgs;
    iozevka-nerd = import ./nerd.nix pkgs;
    iozevka = import ./default.nix pkgs;
  in {
    packages.${system} = {
      inherit iozevka-git iozevka-nerd iozevka;
      default = iozevka;
    };
    overlays.default = final: prev: {
      inherit iozevka iozevka-git iozevka-nerd;
    };
  };
}
