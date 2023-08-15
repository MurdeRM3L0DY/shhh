{
  inputs,
  cell,
}: let
  inherit
    (inputs.haumea.lib)
    load
    transformers
    ;
in {
  importDefault = {
    src,
    inputs ? {},
  }:
    load {
      inherit src inputs;
      transformer = transformers.liftDefault;
    };
}
