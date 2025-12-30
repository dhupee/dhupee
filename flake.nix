{
  description = "Development environment for making Blog using MKDocs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in {
      devShells.default = pkgs.mkShell {
        name = "dhupee-blog";

        packages =
          (with pkgs; [
            python313
          ])
          ++ (with pkgs.python313Packages; [
            # Libraries
            mkdocs
            mkdocs-material
          ]);

        # Shell hook
        shellHook = ''
          export SHELL=$(which ${pkgs.zsh})
          echo 'Development Shell Initialized'
          exec zsh
        '';
      };
    });
}
