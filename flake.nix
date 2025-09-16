{
  description = "A very basic flake";
  inputs = {
    nvf.url = "github:notashelf/nvf";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    copyparty.url = "github:9001/copyparty";
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
    xremap-flake.url = "github:xremap/nix-flake";
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
    copyparty,
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
        config.allowUnfree = true;
        overlays = [
          inputs.hyprpanel.overlay
          copyparty.overlays.default
        ];
      };

    pkgsForUnstable = system:
      import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
  in {
    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/pc/configuration.nix
        inputs.stylix.nixosModules.stylix
        sops-nix.nixosModules.sops
      ];
    };

    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/laptop/configuration.nix
        inputs.stylix.nixosModules.stylix
        sops-nix.nixosModules.sops
      ];
    };

    nixosConfigurations.server = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/server/configuration.nix
        inputs.stylix.nixosModules.stylix
        sops-nix.nixosModules.sops

        # ✅ Copyparty module
        copyparty.nixosModules.default

        # ✅ Extra config for Copyparty
        ({pkgs, ...}: {
          environment.systemPackages = [pkgs.copyparty];
          services.copyparty = {
            enable = true;
            openFirewall = true;
            dataDir = "/srv/copyparty";
            listenAddress = "0.0.0.0";
            port = 3923;
          };
        })
      ];
    };

    homeConfigurations = {
      laptop = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor "x86_64-linux";
        modules = [
          ./home/hosts/laptop.nix
          spicetify-nix.homeManagerModules.default
          nvf.homeManagerModules.default
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
          nvf.homeManagerModules.default
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
          nvf.homeManagerModules.default
        ];
        extraSpecialArgs = {
          inherit inputs;
          pkgs-unstable = pkgsForUnstable "x86_64-linux";
        };
      };
    };
  };
}
