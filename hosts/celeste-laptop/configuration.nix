{ inputs, system, config, pkgs, ... }:
{
  imports = [ 
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager 
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      celeste = import ./home.nix;
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "celeste-laptop";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Brussels";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_BE.UTF-8";
    LC_IDENTIFICATION = "nl_BE.UTF-8";
    LC_MEASUREMENT = "nl_BE.UTF-8";
    LC_MONETARY = "nl_BE.UTF-8";
    LC_NAME = "nl_BE.UTF-8";
    LC_NUMERIC = "nl_BE.UTF-8";
    LC_PAPER = "nl_BE.UTF-8";
    LC_TELEPHONE = "nl_BE.UTF-8";
    LC_TIME = "nl_BE.UTF-8";
  };

  # services.xserver.enable = true;
  # services.xserver.displayManager.gdm.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.celeste = {
    isNormalUser = true;
    description = "Celeste De Schamphelaere";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
    ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    nerdfonts
    roboto-mono
    font-awesome
  ];

  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    home-manager
    bibata-cursors
    discord
    docker
    llvm
    clang
    python3
    nodejs
    vscode
    swiProlog
    git
    firefox
    chromium
    unzip
    qbittorrent
    gnome.nautilus
    obsidian  
    stremio
    waybar
    mako
    pavucontrol
    xorg.xeyes
    kitty
    rofi-wayland
    grim
    slurp
    vlc
    wl-clipboard
    wlsunset
    toybox
    swaybg
  ];

  system.stateVersion = "24.05";
}
