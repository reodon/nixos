{pkgs, ...}: {
  home.packages = with pkgs; [
    # vscode
    vscode.fhs
  ];
}

