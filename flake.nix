{
  description = "The Hive - The secretly open NixOS-Society";

  # hive
  inputs = {
    std = {
      url = "github:divnix/std";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hive = {
      url = "github:divnix/hive";
      inputs = {
        haumea.follows = "haumea";
      };
    };
  };

  # nixpkgs & home-manager
  inputs = {
    nixpkgs.follows = "nixos-23_05";

    nixos-23_05.url = "github:nixos/nixpkgs/release-23.05";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-23_05 = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixos-23_05";
    };
    home-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixos-unstable";
    };
  };

  outputs = {
    self,
    std,
    nixpkgs,
    hive,
    ...
  } @ inputs:
    std.growOn {
      inherit inputs;

      nixpkgsConfig = {
        allowUnfree = true;
      };

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      cellsFrom = ./nix;

      cellBlocks = with std.blockTypes;
      with hive.blockTypes; [
        (functions "users")

        (functions "lib")

        nixosConfigurations
      ];
    }
    {
      nixosConfigurations = hive.collect self "nixosConfigurations";
    };
}
