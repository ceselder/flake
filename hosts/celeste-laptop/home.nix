{ inputs, config, pkgs, ... }:

{


  home.username = "celeste";
  home.homeDirectory = "/home/celeste";

  home.file = {
    ".config/kitty/kitty.conf" = {
        source = ../../config/kitty/kitty.conf; 
        recursive = true;
    };".config/hypr/hyprland.conf" = {
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
  };


  home.packages = with pkgs; [
    # temp
    hdrop
    bibata-cursors
    turbovnc
    gimp

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
  ];

  home.sessionVariables = {
    EDITOR = "nano";
  };

  home.file = {

  };

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;
}
