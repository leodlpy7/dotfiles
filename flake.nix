{
  description = "laptop nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, flake-utils, sops-nix }: {
    nixosConfigurations.notnixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        sops-nix.nixosModules.sops
        ./nixos/laptop
        ./nixos/home-manager/home.nix
      ];
    };
    devShells."x86_64-linux".default = with import nixpkgs {system = "x86_64-linux";};
    mkShell {
      sopsPGPKeyDirs = [
        "${toString ./.}/keys/hosts"
        "${toString ./.}/keys/users"
      ];
      nativeBuildInputs = [
        (pkgs.callPackage sops-nix {}).sops-import-keys-hook
      ];
    };
  };
}
