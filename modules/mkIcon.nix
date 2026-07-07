{ lib, ... }:

{
  flake.lib.mkIcon = code:
    let
      value = lib.fromHexString code;
      encode = x: "\\u${lib.fixedWidthString 4 "0" (lib.toHexString x)}";
      msw = value / 1024 + 55232;
      lsw = lib.mod value 1024 + 56320;
    in
    builtins.fromJSON
      (if value < 65536 then
        "\"${encode value}\""
      else
        "\"${encode msw + encode lsw}\"");
}
