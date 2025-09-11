{
  description = "A very basic flake";
  inputs = {
    # I dont think I need this anymore
    nvf.url = "github:notashelf/nvf";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    hyprland.url = "github:hyprwm/Hyprland";
    # I am not using this right now
    xremap-flake.url = "github:xremap/nix-flake";
    # I dont know if I am using this right now
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    spicetify-nix,
    nixpkgs-unstable,
    home-manager,
    sops-nix,
    nvf,
    ...
  } @ inputs: let
    pkgsFor = system:
      import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          inputs.hyprpanel.overlay # Adding HyprPanel overlay here
        ];
      };

    pkgsForUnstable = system:
      import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
  in {
    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Specify the system type here
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/pc/configuration.nix
        inputs.stylix.nixosModules.stylix
        sops-nix.nixosModules.sops
      ];
    };

    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Specify the system type here
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/laptop/configuration.nix
        inputs.stylix.nixosModules.stylix
        sops-nix.nixosModules.sops
      ];
    };

    nixosConfigurations.server = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Specify the system type here
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/server/configuration.nix
        inputs.stylix.nixosModules.stylix
        sops-nix.nixosModules.sops
      ];
    };
    homeConfigurations = {
      laptop = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor "x86_64-linux";
        modules = [
          ./home/hosts/laptop.nix
          spicetify-nix.homeManagerModules.default
          nvf.homeManagerModules.default # <- adds nvf module
        ];
        extraSpecialArgs = {
          inherit inputs;
          pkgs-unstable = pkgsForUnstable "x86_64-linux";
        };
      };

      server = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor "x86_64-linux";
        modules = [
          ./home/hosts/server.nix
          nvf.homeManagerModules.default # <- adds nvf module
        ];
        extraSpecialArgs = {
          inherit inputs;
          pkgs-unstable = pkgsForUnstable "x86_64-linux";
        };
      };
      pc = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor "x86_64-linux";
        modules = [
          ./home/hosts/pc.nix
          spicetify-nix.homeManagerModules.default

          nvf.homeManagerModules.default # <- adds nvf module
        ];
        extraSpecialArgs = {
          inherit inputs;
          pkgs-unstable = pkgsForUnstable "x86_64-linux";
        };
      };
    };
  };
}
