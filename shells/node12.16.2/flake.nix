{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      
      overrideNodejs = pkgs.stdenv.mkDerivation {
        name = "nodejs";
        src = pkgs.fetchurl {
          url = "https://nodejs.org/dist/v12.16.2/node-v12.16.2-darwin-x64.tar.gz";
          sha256 = "sha256-SDlU4xGl/2Sd3zK0c/Y1pYiQeQ0oS1eIvdjX/4UMbbI=";
        };
        installPhase = ''
          echo "installing nodejs v12.16.2"
          mkdir -p $out
          cp -r ./ $out/
        '';
      };  
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          (pkgs.yarn.override {
            nodejs = overrideNodejs;
          })
          overrideNodejs
        ];

        shellHook = ''
          ssh-add ~/.ssh/id_ed25519_default
        '';
      };
    }
  );
}