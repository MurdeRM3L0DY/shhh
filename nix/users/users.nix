{
  cell,
  inputs,
  ...
}: let
  inherit
    (inputs)
    cells
    ;

  inherit
    (cells.shared.lib)
    importDefault
    ;

  inherit
    (inputs.nixpkgs.lib)
    mapAttrs
    ;

  users = importDefault {
    src = ./users;

    inputs = {
      inherit inputs;
    };
  };
in
  mapAttrs (username: f: let
    modules = f username;
  in rec {
    nixos = cells.nixos.lib.mkNixosUserProfile username (modules.nixos or {});
  })
  users
