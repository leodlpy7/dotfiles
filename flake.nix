{
  description = "Laptop nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-easyroam.url = "github:0x5a4/nix-easyroam";
    iio-hyprland.url = "github:JeanSchoeller/iio-hyprland";
    stylix.url = "github:danth/stylix";
    nixvim.url = "github:nix-community/nixvim";
    zenbrowser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, flake-utils, sops-nix, nix-easyroam, iio-hyprland, stylix, nixvim, zenbrowser }: {
    # nixos config for my laptop
    nixosConfigurations.amaterasu = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        sops-nix.nixosModules.sops
        nix-easyroam.nixosModules.nix-easyroam
        stylix.nixosModules.stylix
        ./machines/amaterasu
        home-manager.nixosModules.home-manager {
	  home-manager = {
	    useGlobalPkgs = true;
	    useUserPackages = true;
	    users.lucysue = import ./home/home.nix;
	    extraSpecialArgs = { inherit inputs; };
	    sharedModules = [ inputs.nixvim.homeManagerModules.nixvim ];
	  };
	}
      ];
    };
    # developer shell stuff
    devShells."x86_64-linux".default = with import nixpkgs { system = "x86_64-linux";  };
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
