{ inputs, config, pkgs, ... }:

{

  home.username = "celeste";
  home.homeDirectory = "/home/celeste";

  home.file = {
    ".config/kitty/kitty.conf" = {
        source = ../../config/kitty/kitty.conf; 
        recursive = true;
    };
    
    ".config/hypr/hyprland.conf" = {
        source = ../../config/hypr/hyprland.conf; 
        recursive = true;
    };

    ".config/waybar/config" = {
        source = ../../config/waybar/config; 
        recursive = true;
    };

    ".config/waybar/style.css" = {
        source = ../../config/waybar/style.css; 
        recursive = true;
    };

    ".config/mako/config" = {
        source = ../../config/mako/config; 
        recursive = true;
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 18;
    };
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  home.packages = with pkgs; [
    # temp
    libsForQt5.kdeconnect-kde
    ollama
    koboldcpp

    #general apps
    gimp
    steam
    libreoffice
    inputs.zen-browser.packages."x86_64-linux".default
    discord
    vscode
    kitty
    obsidian  
    stremio
    caligula
    
    # must haves
    gnumake
    openssl
    cmake
    direnv
    nix-direnv
    cargo
    playerctl
    typescript
    mlocate
    brightnessctl
    psmisc #killall enzo
    docker
    llvm
    clang
    python3
    #nodejs_22
    nodejs_20
    git
    unzip
    qbittorrent
    gnome.nautilus
    pavucontrol
    vlc
    clipgrab
    lxqt.lxqt-policykit
    
    # hyprland/wayland stuff
    mako
    rofi-wayland
    waybar
    grim
    slurp
    wl-clipboard   
    wlsunset
    swaybg
    hdrop
  ];

  home.sessionVariables = {
    EDITOR = "nano"; # :3
    BROWSER = "zen-browser";
  };

  home.file = {

  };

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;
}
