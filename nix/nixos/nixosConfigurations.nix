{
  inputs,
  cell,
}: let
  inherit
    (inputs.cells.shared)
    lib
    ;

  inherit
    (inputs.nixpkgs.lib)
    mapAttrs
    ;

  hosts = lib.importDefault {
    src = ./hosts;
    inputs = {
      inherit inputs;
    };
  };
in
  mapAttrs (hostname: module: {
    imports = [module];

    _module.args = {
      inherit hostname;
    };
  })
  hosts
