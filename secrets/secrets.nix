let
  asustor = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqZ1H6r1CiYmibRCWQkY/mEnbsrSQf69OoBA/uGv9b2";
in
{
  # Generate with nix run github:ryantm/agenix -- -e mySecret.age
  # "mySecret.age" = {
  #   publicKeys = [ asustor ];
  #   armor = true;
  # };
  "ddns-updater-config-json.age" = {
    publicKeys = [ asustor ];
    armor = true;
  };
}
