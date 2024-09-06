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

  services.getty.autologinUser = "celeste";
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "celeste";
      };
      default_session = initial_session;
    };
  };

  services.gvfs.enable = true; #this makes it so usb drives mount
  services.udisks2.enable = true; #this makes it so usb drives mount

  boot = {
    initrd.kernelModules = [ "amdgpu" ]; #needed for boot splash
    loader = {
       systemd-boot.enable = true;
       efi.canTouchEfiVariables = true;
     };

    plymouth = {
      logo = ../../img/cat_boot.png;
      enable = true;
      theme = "breeze";
    };

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    # It's still possible to open the bootloader list by pressing any key
    loader.timeout = 0;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/celeste/flake#celeste-laptop; hyprctl reload";
      update = "pushd /home/celeste/flake; sudo nix flake update; popd";
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

  };

  system.stateVersion = "24.05";
}
