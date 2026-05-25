{ config, lib, pkgs, ... }:

{
  programs.direnv.enable = true;

  # Enable direnv hook for the shell (e.g., bash)
  programs.bash.interactiveShellInit = ''
    eval "$(direnv hook bash)"
  '';
}
