{ inputs, system, config, pkgs, ... }:
{
  imports = [ 
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager 
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    backupFileExtension = "hmbackup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      celeste = import ./home.nix;
    };
  };

  services.gvfs.enable = true; #this makes it so usb drives mount
  services.udisks2.enable = true; #this makes it so usb drives mount


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/celeste/flake#celeste-laptop";
    };

    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "alanpeabody";
    };
  };

  users.users.celeste.shell = pkgs.zsh;

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


  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [ 
      inconsolata
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      nerdfonts
      roboto-mono
      font-awesome
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "Inconsolata" ];
      };
    };
  };

  system.stateVersion = "24.05";
}
