{ lib, ... }:

{
  den.schema.user = {
    options = {
      graphical = lib.mkOption {
        type = lib.types.bool;
        description = "Whether the user (in the host context) is a graphical user.";
        default = true;
      };

      displayName = lib.mkOption {
        type = lib.types.str;
        description = "The user's display name.";
      };
      email = lib.mkOption {
        type = lib.types.str;
        description = "The user's email contant.";
      };
    };
  };
}
