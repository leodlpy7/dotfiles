{
  description = "Laptop nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-easyroam.url = "github:0x5a4/nix-easyroam";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, flake-utils, sops-nix, nix-easyroam }: {
    # nixos config for my laptop
    nixosConfigurations.amaterasu = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        sops-nix.nixosModules.sops
        nix-easyroam.nixosModules.nix-easyroam
        ./machines/amaterasu
	      home-manager.nixosModules.home-manager {
	        home-manager.useGlobalPkgs = true;
	        home-manager.useUserPackages = true;
	        home-manager.users.lucysue = import ./home/home.nix;
	      }
      ];
    };
    # developer shell stuff
    devShells."x86_64-linux".default = with import nixpkgs {system = "x86_64-linux";};
    mkShell {
      sopsPGPKeyDirs = [
        "${toString ./.}/resources/keys/hosts"
        "${toString ./.}/resources/keys/users"
      ];
      nativeBuildInputs = [
        (pkgs.callPackage sops-nix {}).sops-import-keys-hook
      ];
    };
  };
}
