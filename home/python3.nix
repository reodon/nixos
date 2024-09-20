# {
#   programs.python3 = {
#     enable = true;
#   };
# }
{pkgs, ...}: {
  home.packages = with pkgs; [
    python3
  ];
}

