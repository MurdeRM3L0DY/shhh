{inputs, ...}: let
  system = "x86_64-linux";
  home = inputs.home-unstable;
  pkgs = import inputs.nixos-unstable {
    inherit system;
  };
  users = inputs.cells.users.users;
in {
  imports = [
    {
      system.stateVersion = "23.11";
    }

    # # This doesn't for some reason... :(
    # (users.nemesis.nixos {
    #   extraGroups = ["@wheel"];
    # })
  ];

  bee = {
    inherit system pkgs home;
  };
}
