# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # ## 環境に応じてインポートするモジュールを変更してください
  # ++ (with inputs.nixos-hardware.nixosModules; [
  #   common-cpu-amd
  #   common-gpu-nvidia
  #   common-pc-ssd
  # ]);
  # ## xremapのNixOS modulesを使えるようにする
  # ++ [
  #   inputs.xremap.nixosModules.default
  # ]
  # ## xremapでキー設定をいい感じに変更
  # services.xremap = {
  #   userName = "ユーザー名";
  #   serviceMode = "system";
  #   config = {
  #     modmap = [
  #       {
  #         # CapsLockをCtrlに置換
  #         name = "CapsLock is dead";
  #         remap = {
  #           CapsLock = "Ctrl_L";
  #         };
  #       }
  #     ];
  #     keymap = [
  #       {
  #         # Ctrl + HがどのアプリケーションでもBackspaceになるように変更
  #         name = "Ctrl+H should be enabled on all apps as BackSpace";
  #         remap = {
  #           C-h = "Backspace";
  #         };
  #         # 一部アプリケーション（ターミナルエミュレータ）を対象から除外
  #         application = {
  #           not = ["Alacritty" "Kitty" "Wezterm"];
  #         };
  #       }
  #     ];
  #   };
  # };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen; # カーネルを変更する

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  services.udev.extraRules = builtins.readFile ./root/etc/udev/rules.d/99-platformio-udev.rules;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.reodon = {
    isNormalUser = true;
    description = "reodon";
    extraGroups = [ "dialout" "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];

    # shell = pkgs.zsh;
    # programs = {
    #   starship = {
    #     enable = true;
    #   };
    # };
  };

  # # Install firefox.
  # programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    xwaylandvideobridge
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  nix = {
    settings = {
      auto-optimise-store = true; # Nix storeの最適化
      experimental-features = ["nix-command" "flakes"];
    };
    ## ガベージコレクションを自動実行
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  programs = {
    noisetorch.enable = true; # マイク用ノイズ低減アプリ
    git = {
      enable = true;
    };
    zsh = {
      enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = [pkgs.fcitx5-mozc];
  };

  fonts = {
    fonts = with pkgs; [
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerdfonts
    ];
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
	serif = ["Noto Serif CJK JP" "Noto Color Emoji"];
        sansSerif = ["Noto Sans CJK JP" "Noto Color Emoji"];
        monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  # ## tailscale（VPN）を有効化
  # ## 非常に便利なのでおすすめ
  # services.tailscale.enable = true;
  # networking.firewall = {
  #   enable = true;
  #   ## tailscaleの仮想NICを信頼する
  #   ## `<Tailscaleのホスト名>:<ポート番号>`のアクセスが可能になる
  #   trustedInterfaces = ["tailscale0"];
  #   allowedUDPPorts = [config.services.tailscale.port];
  # };

  ## Dockerをrootlessで有効化
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true; # $DOCKER_HOSTを設定
      };
    };
  };

  # ## Linuxデスクトップ向けのパッケージマネージャ
  # ## アプリケーションをサンドボックス化して実行する
  # ## NixOSが対応していないアプリのインストールに使う
  # services.flatpak.enable = true;
  # xdg.portal.enable = true; # flatpakに必要

  # ## Steamをインストール
  # ## Proton ExperimentalはSteamの設定から有効化する
  # programs.steam = {
  #   enable = true;
  #   remotePlay.openFirewall = true;
  #   dedicatedServer.openFirewall = true;
  # };
  # ## Steamのフォントが文字化けするので、フォント設定を追加
  # ## SteamだけフォントをMigu 1Pにする
  # fonts = {
  #   fonts = with pkgs; [
  #     # ...
  #     migu
  #   ];
  #   fontDir.enable = true;
  #   fontconfig = {
  #     # ...
  #     localConf = ''
  #       <?xml version="1.0"?>
  #       <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
  #       <fontconfig>
  #         <description>Change default fonts for Steam client</description>
  #         <match>
  #           <test name="prgname">
  #             <string>steamwebhelper</string>
  #           </test>
  #           <test name="family" qual="any">
  #             <string>sans-serif</string>
  #           </test>
  #           <edit mode="prepend" name="family">
  #             <string>Migu 1P</string>
  #           </edit>
  #         </match>
  #       </fontconfig>
  #     '';
  #   };
  # };

  # services.fprintd = {
  #   enable = true;
  #   package = pkgs.fprintd-tod;
  #   # tod = {
  #   #   enable = true;
  #   #   driver = pkgs.libfprint-2-tod1-vfs0090;
  #   # };
  # };
}

