{
  config,
  username,
  ...
}:

{

  age.secrets = {
    pwncollege-ssh = {
      file = ../../secrets/MacBook-Pro-M4-pwncollege.age;
      owner = username;
      group = "staff";
    };
  };

  home-manager.users.${username} = {
    programs.ssh = {
      enable = true;

      settings."pwn.college" = {
        hostname = "dojo.pwn.college";
        user = "hacker";
        identityFile = config.age.secrets.pwncollege-ssh.path;
        identitiesOnly = true;
      };
    };
  };
}
