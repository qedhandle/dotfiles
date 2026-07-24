{ narbix, inputs, ... }:

let
  inherit (inputs.self.lib) mkIcon;
in
{
  narbix.starship._.powerline = {
    includes = [ narbix.starship ];

    homeManager = { lib, ... }: {
      programs.starship.settings = {
        format = lib.join "\n" [
          "$directory$direnv$git_branch$git_commit$fill$status"
          "$character"
        ];
        add_newline = true;

        character = {
          format = "$symbol ";
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
        };

        directory = {
          truncate_to_repo = true;
          style = "bold cyan";
          read_only = mkIcon "f023";
          read_only_style = "yellow";
        };

        direnv = {
          disabled = false;
          format = "[$loaded]($style) ";
          style = "cyan";
          loaded_msg = mkIcon "f07c";
          unloaded_msg = mkIcon "f07b";
        };

        fill.symbol = " ";

        git_branch = {
          format = "on [$symbol$branch(:$remote_branch)]($style) ";
          symbol = "${mkIcon "e725"} ";
          style = "purple";
        };

        git_commit = {
          format = "[${mkIcon "e729"} $hash$tag]($style) ";
          style = "purple";
          tag_symbol = mkIcon "f04fc";
        };

        status = {
          disabled = false;
          format = "[$symbol $status]($style)";
          style = "red";
          success_style = "green";
          symbol = mkIcon "f05c";
          success_symbol = mkIcon "f05d";
          not_executable_symbol = mkIcon "f05e";
          not_found_symbol = mkIcon "f002";
          sigint_symbol = mkIcon "f28e";
          signal_symbol = mkIcon "f0e7";
        };
      };
    };
  };
}
