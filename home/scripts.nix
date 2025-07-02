{
  config,
  pkgs,
  ...
}: {
  home.file."scripts/toggle_idle.sh" = {
    source = ./scripts/toggle_idle.sh;
    executable = true;
  };

  home.file."scripts/idle_status.sh" = {
    source = ./scripts/idle_status.sh;
    executable = true;
  };

  home.file."scripts/toggle-wk.sh" = {
    source = ./scripts/toggle-wk.sh;
    executable = true;
  };
}
