{
  description = "iozevka";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-22.11";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system} = {
      iozevka-git = import ./build.nix pkgs;
      iozevka = import ./default.nix pkgs;
      default = self.packages.${system}.iozevka;
    };
  };
}
