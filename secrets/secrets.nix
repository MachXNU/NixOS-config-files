let
  macbook-pro-m4 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKowU0cheZvziZQytTqOVF9LMzztug4tvQLPQHFB1H4i";
in
{
  # Generate with nix run github:ryantm/agenix -- -e mySecret.age
  # "mySecret.age" = {
  #   publicKeys = [ asustor ];
  #   armor = true;
  # };
  "MacBook-Pro-M4-ProtonVPN-Netherlands-NL-752.age" = {
    publicKeys = [ macbook-pro-m4 ];
    armor = true;
  };
}
