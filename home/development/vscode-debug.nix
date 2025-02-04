{
  pkgs,
  lib,
  ...
}:
pkgs.stdenv.mkDerivation rec {
  pname = "vscode-js-debug";
  version = "1.74.0"; # Change this to the version/tag you need

  # Replace with the appropriate source (git revision, tag, etc.)
  src = pkgs.fetchFromGitHub {
    owner = "microsoft";
    repo = "vscode-js-debug";
  };

  buildInputs = [pkgs.nodejs];

  # You may need to set NODE_ENV to "production" or other environment variables if required.
  buildPhase = ''
    npm install --legacy-peer-deps
    npx gulp vsDebugServerBundle
    mv dist out
  '';

  installPhase = ''
    mkdir -p $out
    cp -r out/* $out
  '';

  meta = with lib; {
    description = "VSCode Debug Adapter for JavaScript debugging";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
