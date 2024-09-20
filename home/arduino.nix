# {
#   programs.arduino = {
#     enable = true;
#   };
# }
{pkgs, ...}: {
  home.packages = with pkgs; [
    arduino
    arduino-cli
    # arduino-ide

    platformio
    avrdude
  ];
}

