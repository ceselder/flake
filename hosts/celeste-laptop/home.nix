{ inputs, config, pkgs, ... }:

{


  home.username = "celeste";
  home.homeDirectory = "/home/celeste";


  home.packages = with pkgs; [
    # temp
    bibata-cursors

    #general apps
    kdePackages.dolphin
    inputs.zen-browser.packages."x86_64-linux".default
    discord
    vscode
    kitty
    obsidian  
    stremio
    caligula
    
    # must haves
    docker
    llvm
    clang
    python3
    nodejs
    git
    unzip
    qbittorrent
    gnome.nautilus
    pavucontrol
    vlc
    
    # hyprland/wayland stuff
    mako
    rofi-wayland
    waybar
    grim
    slurp
    wl-clipboard
    wlsunset
    swaybg
  ];

  home.sessionVariables = {
    EDITOR = "nano";
  };

  home.file = {

  };

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;
}
