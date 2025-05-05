{ inputs, config, pkgs, ... }:
let
buildToolsVersion = "33.0.2";
androidComposition = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = [ buildToolsVersion ];
}; 
in
{
  programs.zsh.enable = true;

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



  home.packages = with pkgs; [
    openboardview
    kdePackages.okular
    handbrake
    ffmpeg
    v4l-utils
    mpv
    guvcview
    drawio
    jflap
    darktable    
    thonny
    bind
    usbutils
    kdePackages.partitionmanager
    fusee-launcher
    anki
    yt-dlp
    obs-studio
    rustc
    rustfmt
    cargo
    lapack    
    rust-analyzer
    pomodoro-gtk
    audacity
    apktool
    apksigner
    r2modman
    
    #python pkgs
    python312
    libxkbcommon
    glbinding
    ocl-icd
    clinfo
    firefox
    #python312Packages.manim
    mesa.opencl
    mesa
    thonny
    chromium
    wayland
  
    # temp
    pulseeffects-legacy
    wine
    eid-mw
    telegram-desktop
    spotify
    #citrix_workspace    
    neovim

    #general apps
    gimp
    onlyoffice-bin
    libreoffice
    inputs.zen-browser.packages."x86_64-linux".default
    inputs.openconnect-sso.packages."x86_64-linux".default
    discord
    vscode
    kitty
    obsidian  
    stremio
    caligula
    xz
    
    # must haves
    wget
    gnat    
    libgcc
    android-tools
    gnumake
    openssl
    cmake
    direnv
    nix-direnv
    prisma-engines
    nodePackages.prisma
    cargo
    playerctl
    typescript
    mlocate
    brightnessctl
    unrar
    psmisc #killall enzo
    docker
    llvm
    #nodejs_22
    nodejs_20
    git
    unzip
    nautilus
    pavucontrol
    vlc
    clipgrab
    lxqt.lxqt-policykit
    busybox
    
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

  home.shellAliases = {
  sudo = "sudo ";
  zipalign = "${androidComposition.androidsdk}/libexec/android-sdk/build-tools/${buildToolsVersion}/zipalign";
  };

  home.file = {

  };

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;



}
