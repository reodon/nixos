{
  imports = [
    # ./zsh.nix
    # ./starship.nix
    # ./neovim.nix
    # ./direnv.nix
    # ./development.nix
    # ./wezterm.nix
    ./home/python3.nix

    ./home/apps.nix
    ./home/browser.nix

    ./home/vscode.nix
    ./home/arduino.nix
  ];

  home = rec { # recでAttribute Set内で他の値を参照できるようにする
    username="reodon";
    homeDirectory = "/home/${username}"; # 文字列に値を埋め込む
    # stateVersion = "22.11";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true; # home-manager自身でhome-managerを有効化
}

