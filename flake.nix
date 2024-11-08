{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    hyprland.url = "github:hyprwm/Hyprland";
    xremap-flake.url = "github:xremap/nix-flake";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... } @ inputs:
  let
    pkgsFor = system:
      import nixpkgs {
        inherit system;
        overlays = [
          inputs.hyprpanel.overlay # Adding HyprPanel overlay here
        ];
      };

    pkgsForUnstable = system:
      import nixpkgs-unstable {
        inherit system;
      };
  in {
    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Specify the system type here
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/pc/configuration.nix
      ];
    };

    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Specify the system type here
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/laptop/configuration.nix
      ];
    };

    homeConfigurations = {
      simon = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor "x86_64-linux";
        modules = [
          ./home/home.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
          pkgs-unstable = pkgsForUnstable "x86_64-linux";
        };
      };
    };
  };
}
