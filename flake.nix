# For info on Flakes, see: https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-with-flakes-enabled
{
  description = "Bigli's system Flake";

  inputs = {
    # Import the desired Nix channel. Defaults to unstable, which uses a fully tested rolling release model.
    #   You can find a list of channels at https://wiki.nixos.org/wiki/Channel_branches
    #   To follow a different channel, replace `nixos-unstable` with the channel name, e.g. `nixos-24.05`.
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Home-manager support
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # SecureBoot support
    lanzaboote.url = "github:nix-community/lanzaboote?ref=master";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Use Auxolotl lib
    lib.url = "git+https://git.auxolotl.org/auxolotl/lib?ref=main";

    # NixOS hardware quirks
    nixos-hardware.url = "github:NixOS/nixos-hardware?ref=master";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets = {
      url = "git+ssh://git@github.com/TheBigLee/nix-secrets.git?ref=main&shallow=1";
      inputs = { };
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    stylix.url = "github:danth/stylix";

    # Code formatter
    treefmt = {
      url = "github:numtide/treefmt-nix?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      home-manager,
      lanzaboote,
      nixos-hardware,
      nixpkgs,
      nixpkgs-unstable,
      hyprland,
      hyprpanel,
      stylix,
      self,
      systems,
      treefmt,
      ...
    }:
    let
      inherit (self) outputs;

      forEachSystem =
        function: nixpkgs.lib.genAttrs (import systems) (system: function nixpkgs.legacyPackages.${system});

      treefmtEval = forEachSystem (pkgs: treefmt.lib.evalModule pkgs ./treefmt.nix);

      # ========== Extend lib with lib.custom ==========
      # NOTE: This approach allows lib.custom to propagate into hm
      # see: https://github.com/nix-community/home-manager/pull/3454
      lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });

      systemSettings = {
        timezone = "Europe/Zurich";
        locale = "en_US.UTF-8";
      };
    in
    {
      checks = forEachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });
      formatter = forEachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = nixpkgs.lib.nixosSystem {
            modules = [ ./hosts/nixos/${host} ];
            specialArgs = {
              inherit inputs outputs lib systemSettings;
            };
          };
        }) (builtins.attrNames (builtins.readDir ./hosts/nixos))
      );
    };
}
