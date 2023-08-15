{
  self,
  inputs,
  ...
}: username: {
  nixos = {pkgs, ...}: {
    imports = [];

    users.users.${username} = {
      shell = pkgs.zsh;
    };
  };
}
