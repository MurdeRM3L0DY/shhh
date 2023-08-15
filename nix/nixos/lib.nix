{
  inputs,
  cell,
}: {
  mkNixosUserProfile = name: module: override: {
    config,
    lib,
    pkgs,
    ...
  }: {
    imports = [module];

    users.users.${name} =
      override
      // {
        inherit name;

        isNormalUser = true;

        home =
          if pkgs.stdenv.isDarwin
          then "/Users/${name}"
          else "/home/${name}";
      };
  };
}
