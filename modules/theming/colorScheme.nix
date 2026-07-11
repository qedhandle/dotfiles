{ den, lib, ... }:

{
  den.quirks.colorSchemePorts = {
    description = ''
      Request a port for the color scheme.

      Use `colorSchemePorts = [ "my-port" ];` to load `my-port`.
    '';
  };

  den.policies.collect-ports = { user, ... }:
    let inherit (den.lib.policy) pipe; in [
      (pipe.from "colorSchemePorts" [
        (pipe.for lib.uniqueStrings)
      ])
    ];

  den.schema.user.includes = [ den.policies.collect-ports ];
}
