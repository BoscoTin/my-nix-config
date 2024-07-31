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
          url = "https://nodejs.org/dist/v18.16.0/node-v18.16.0-darwin-arm64.tar.gz";
          sha256 = "sha256-gse7SGlBnOczhmnmc5p4bfx+cvJ2/77WY/hf/JBdzbQ=";
        };
        installPhase = ''
          echo "installing nodejs v18.16.0"
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