{
  pkgs,
  inputs,
  ...
}: {
  # home.packages = with pkgs; [
  # spotify
  # ];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
    theme = inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.catppuccin;
    colorScheme = "mocha";
  };
}
