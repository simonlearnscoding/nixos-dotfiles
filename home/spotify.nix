{
  pkgs,
  inputs,
  ...
}: {
  # home.packages = with pkgs; [
  # spotify
  # ];
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    spicetifyPackage = inputs.nixpkgs-unstable.legacyPackages."${pkgs.system}".spicetify-cli; # added this
    enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];

    theme = spicePkgs.themes.catppuccin;

    colorScheme = "mocha";
  };
}
