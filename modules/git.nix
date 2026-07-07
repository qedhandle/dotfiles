{ ... }:

{
  narbix.git = {
    homeManager = { user, ... }: {
      programs.git = {
        enable = true;
        settings = {
          init.defaultBranch = "main";
          user.name = user.displayName;
          user.email = user.email;
        };
      };
    };
  };
}
