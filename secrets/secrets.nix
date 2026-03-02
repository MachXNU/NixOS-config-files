let
  asustor = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqZ1H6r1CiYmibRCWQkY/mEnbsrSQf69OoBA/uGv9b2";
in
{
  "secret1.age" = {
    publicKeys = [ asustor ];
    path = "/run/secrets/secret1";
    armor = true;
  };
}
