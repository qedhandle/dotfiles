{ inputs, ... }:

{
  imports = [ (inputs.den.namespace "narbix" false) ];
}
