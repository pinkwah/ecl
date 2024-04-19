{
  inputs.nixpkgs.url = "nixpkgs/nixos-23.11-small";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        pypkgs = pkgs.python3Packages;

        resdata = pypkgs.callPackage ./nixpkgs/package.nix { src = ./.; };
      in {
        formatter = pkgs.nixfmt;

        packages = {
          inherit resdata;

          default = resdata;

          env = pypkgs.python.withPackages (ps: [ resdata ps.pytest ]);
        };

        devShells.default = pkgs.mkShell {
          name = "resdata";

          packages = [ resdata ];
        };
      });
}
