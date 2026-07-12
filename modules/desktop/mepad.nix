{ narbix, ... }:

{
  narbix.mepad = {
    includes = with narbix; [
      desktop
      fontScheme
      hyprland._.basic-dwindle
      hyprlock
      hyprlauncher
      hyprshutdown
      hyprpicker
      hypridle
      hyprsunset
      waybar._.basic-bar
      (waybar._.hyprland-workspaces { position = "left"; })
      mako
      pipewire
      brightnessctl
      alacritty
    ];
  };
}
