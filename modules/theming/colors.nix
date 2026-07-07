{ lib, inputs, ... }:

let
  srgbToHSLV = { r, g, b }:
    let
      M = lib.foldr (x: y: if x < y then y else x) 0.0 [ r g b ];
      m = lib.foldr (x: y: if x < y then x else y) 1.0 [ r g b ];
      C = M - m;
      H' =
        if C == 0.0 then
          0.0
        else if M == r then
          if g >= b then
            (g - b) / C
          else
            (g - b) / C + 6.0
        else if M == g then
          (b - r) / C + 2.0
        else
          (r - g) / C + 4.0;
      H = H' * 60.0;
      V = M;
      L = (M + m) / 2.0;
      Sv = if V == 0.0 then 0.0 else C / V;
      Sl =
        if L == 0.0 || L == 1.0 then
          0.0
        else if L < 0.5 then
          C / (2.0 * L)
        else
          C / (2.0 * (1.0 - L));
    in {
      h = H; sv = Sv; sl = Sl; v = V; l = L;
    };
  srgbFromHCM = { h, c, m }:
    if h < 1.0 then
      let x = c * h; in
      { r = c + m; g = x + m; b = m; }
    else if h < 2.0 then
      let x = c * (2.0 - h); in
      { r = x + m; g = c + m; b = m; }
    else if h < 3.0 then
      let x = c * (h - 2.0); in
      { r = m; g = c + m; b = x + m; }
    else if h < 4.0 then
      let x = c * (4.0 - h); in
      { r = m; g = x + m; b = c + m; }
    else if h < 5.0 then
      let x = c * (h - 4.0); in
      { r = x + m; g = m; b = c + m; }
    else
      let x = c * (6.0 - h); in
      { r = c + m; g = m; b = x + m; };
in
{
  flake.lib.color = rec {
    rgbType = lib.mkOptionType {
      name = "rgb";
      description = "rgb color (0.0 - 1.0)";
      check = value:
        builtins.isAttrs value
        && builtins.attrNames value == [ "b" "g" "r" ]
        && builtins.all
            (v: builtins.isFloat v && v >= 0.0 && v <= 1.0)
            (with value; [ r g b ]);
    };
    srgb.fromHex = hexcode:
      assert builtins.isString hexcode;
      assert builtins.match "#[0-9A-Fa-f]{6}" hexcode != null;
      let
        matches =
          builtins.match
            "^#([0-9A-Fa-f]{2})([0-9A-Fa-f]{2})([0-9A-Fa-f]{2})$"
            hexcode;
        r = builtins.elemAt matches 0;
        g = builtins.elemAt matches 1;
        b = builtins.elemAt matches 2;
      in {
        r = lib.fromHexString r / 255.0;
        g = lib.fromHexString g / 255.0;
        b = lib.fromHexString b / 255.0;
      };
    srgb.toHex = { r, g, b }:
      let
        round = v: builtins.floor (v + 0.5);
        convert = v:
          lib.fixedWidthString 2 "0" (lib.toHexString (round (v * 255)));
      in
        "#${convert r}${convert g}${convert b}";
    srgb.toCSS_RGBA = color: srgb.toCSS_RGBA_withAlpha { inherit color; alpha = 1.0; };
    srgb.toCSS_RGBA_withAlpha = { color, alpha }:
      let
        round = v: builtins.floor (v + 0.5);
        convert = v: builtins.toString (round (v * 255));
      in
      "rgba(${convert color.r}, ${convert color.g}, ${convert color.b}, ${builtins.toString alpha})";
    srgb.toHSL = { r, g, b }@color:
      let hslv = srgbToHSLV color; in {
        h = hslv.h;
        s = hslv.sl;
        l = hslv.l;
      };
    srgb.toHSV = { r, g, b }@color:
      let hslv = srgbToHSLV color; in {
        h = hslv.h;
        s = hslv.sv;
        v = hslv.v;
      };
    srgb.toCIEXYZ = { r, g, b }:
      let
        inherit (inputs.nix-math.lib.math) pow;
        f = v:
          if v <= 0.04045 then
            v / 12.92
          else
            pow ((v + 0.055) / 1.055) 2.4;
        r' = f r;
        g' = f g;
        b' = f b;
      in {
        x = 0.4124 * r' + 0.3576 * g' + 0.1805 * b';
        y = 0.2126 * r' + 0.7152 * g' + 0.0722 * b';
        z = 0.0193 * r' + 0.1192 * g' + 0.9505 * b';
      };
    srgb.over = { r, g, b }@c1: alpha: { r, g, b }@c2:
      {
        r = c1.r * alpha + c2.r * (1 - alpha);
        g = c1.g * alpha + c2.g * (1 - alpha);
        b = c1.b * alpha + c2.b * (1 - alpha);
      };
    hsv.toSRGB = { h, s, v }:
      let c = s * v; in
      srgbFromHCM { h = h / 60.0; c = c; m = v - c; };
    hsv.toHex = { h, s, v }@color:
      srgb.toHex (hsv.toSRGB color);
    hsl.toSRGB = { h, s, l }:
      let c = if l < 0.5 then 2.0 * l * s else 2.0 * (1.0 - l) * s; in
      srgbFromHCM { h = h / 60.0; c = c; m = l - c / 2.0; };
    hsl.toHex = { h, s, l }@color:
      srgb.toHex (hsl.toSRGB color);
    ciexyz.toSRGB = { x, y, z }:
      let
        inherit (inputs.nix-math.lib.math) pow;
        r = 3.2406255 * x - 1.5372080 * y - 0.4986286 * z;
        g = -0.9689307 * x + 1.8757561 * y + 0.0415175 * z;
        b = 0.0557101 * x - 0.2040211 * y + 1.0569959 * z;
        f = v:
          if v <= 0.0031308 then
            12.92 * v
          else
            1.055 * pow v (1.0 / 2.4) - 0.055;
        clamp = v: if v < 0.0 then 0.0 else if v > 1.0 then 1.0 else v;
      in {
        r = clamp (f r);
        g = clamp (f g);
        b = clamp (f b);
      };
    ciexyz.toCIELAB = { x, y, z }:
      let
        inherit (inputs.nix-math.lib.math) pow;
        x' = x / 0.9505;
        y' = y;
        z' = z / 1.089;
        d = 6.0 / 29.0;
        f = t:
          if t > d * d * d then
            pow t (1.0 / 3.0)
          else
            t / (3 * d * d) + 4.0 / 29.0;
      in {
        l = 116.0 * f y' - 16.0;
        a = 500.0 * (f x' - f y');
        b = 200.0 * (f y' - f z');
      };
    cielab.toCIEXYZ = { l, a, b }:
      let
        fy = (l + 16.0) / 116.0;
        fx = a / 500.0 + fy;
        fz = fy - b / 200.0;
        d = 6.0 / 29.0;
        f' = v:
          if v * v * v > d then
            v * v * v
          else
            (v + 4.0 / 29.0) * 3 * d * d;
      in {
        x = (f' fx) * 0.9505;
        y = (f' fy);
        z = (f' fz) * 1.089;
      };
    cielab.toCIELCH = { l, a, b }:
      let
        inherit (inputs.nix-math.lib.math) sqrt abs atan epsilon pi;
      in {
        inherit l;
        c = sqrt (a * a + b * b);
        h =
          if abs a <= epsilon then
            if abs b <= epsilon then
              0.0
            else if b > 0.0 then
              90.0
            else
              270.0
          else if a > 0.0 then
            if b >= 0.0 then
              atan (b / a) * 180 / pi
            else
              atan (b / a) * 180 / pi + 360
          else
            atan (b / a) * 180 / pi + 180;
      };
    cielch.toCIELAB = { l, c, h }:
      let
        inherit (inputs.nix-math.lib.math) deg2rad sin cos;
      in {
        inherit l;
        a = c * cos (deg2rad h);
        b = c * sin (deg2rad h);
      };
  };
}
