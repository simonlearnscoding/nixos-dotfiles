{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    xremap-flake.url = "github:xremap/nix-flake";
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      };
#   hyprland-plugins = {
#     url = "github:hyprwm/hyprland-plugins";
#     inputs.hyprland.follows = "hyprland";
#   };
  # stylix.url = "github:danth/stylix";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, nixvim, home-manager, ... }@inputs:
    let
      pkgsFor = system: import nixpkgs {
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
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
