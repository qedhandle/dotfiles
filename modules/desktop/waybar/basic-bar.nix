{ narbix, ... }:

{
  narbix.waybar.provides.basic-bar = {
    includes = with narbix.waybar._; [
      narbix.waybar

      (user { position = "center"; })

      (power-menu { order = 2100; })
      (clock { order = 2000; })
      (battery { order = 1900; })
      (wireplumber { order = 1800; })
      (network { order = 1700; })
      (disk { order = 1600; })
      (memory { order = 1500; })
      (cpu { order = 1400; })
    ];
  };
}
