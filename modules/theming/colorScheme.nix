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
      (pipe.from "colorScheme" [
        (pipe.fold (acc: schemes: acc ++ schemes) [])
        (pipe.for lib.uniqueStrings)
      ])
    ];

  den.default.includes = [ den.policies.collect-ports ];
}
