{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    xremap-flake.url = "github:xremap/nix-flake";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      };
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable,  home-manager, ... }@inputs:
    let
      pkgsFor = system: import nixpkgs {
        inherit system;
      };

      pkgsForUnstable = system: import nixpkgs-unstable {
        inherit system;
      };
    in
    {
#     devShells.x86_64-linux.default = import /home/simon/.nixos/shell.nix { inherit nixpkgs; };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";  # Specify the system type here
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
    #     inputs.stylix.nixosModules.stylix
        ];
      };

      homeConfigurations = {
        simon = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor "x86_64-linux";
          modules = [
  #       inputs.stylix.nixosModules.stylix
            ./home/home.nix
          ];
          extraSpecialArgs = {  inherit inputs ; pkgs-unstable = pkgsForUnstable "x86_64-linux"; };
        };
      };
    };
}
