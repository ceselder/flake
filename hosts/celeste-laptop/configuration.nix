{ inputs, system, config, pkgs, ... }:
{
  imports = [ 
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager 
  ];

  # kdeconnect
  networking = {
    firewall.enable = true;
    firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764;} ];
    firewall.allowedUDPPortRanges = [ { from = 1714; to = 1764;} ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  networking.wireless = {
    enable = true;
    networks = {
        Sfeer.psk = "schamphelaere";
        K9B.psk = "Kaaitvaart9";
    };
  };

  home-manager = {
    backupFileExtension = "hmbackup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      celeste = import ./home.nix;
    };
  };

  services.pcscd.enable = true;

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

  #prisma envvars needed to make prisma work
  environment.sessionVariables = { NIXOS_OZONE_WL = 1; 
                                   PRISMA_QUERY_ENGINE_BINARY ="../../../../../nix/store/5s9vyasvg1g65pd2v7m62qyyzrwkj2s3-prisma-engines-5.12.1/bin/query-engine";
                                   PRISMA_QUERY_ENGINE_LIBRARY = "../../../../../nix/store/5s9vyasvg1g65pd2v7m62qyyzrwkj2s3-prisma-engines-5.12.1/lib/libquery_engine.node";
                                   PRISMA_SCHEMA_ENGINE_BINARY = "../../../../../nix/store/5s9vyasvg1g65pd2v7m62qyyzrwkj2s3-prisma-engines-5.12.1/bin/schema-engine" ;
                                   PRISMA_FMT_BINARY = "../../../../../nix/store/5s9vyasvg1g65pd2v7m62qyyzrwkj2s3-prisma-engines-5.12.1/bin/prisma-fmt" ;
                                   PRISMA_ENGINES_CHECKSUM_IGNORE_MISSING = 1; };

  services.gvfs.enable = true; #this makes it so usb drives mount
  services.udisks2.enable = true; #this makes it so usb drives mount

  services.locate.enable = true;
  services.locate.package = pkgs.mlocate;
  services.locate.localuser = null; #had to to silence annoying debug message just kinda ignore this line

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  
  services.blueman.enable = true;


    hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages_5.clr.icd
      rocmPackages_5.clr
      rocmPackages_5.rocminfo
      rocmPackages_5.rocm-runtime
    ];
  };
  # This is necesery because many programs hard-code the path to hip
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages_5.clr}"
  ];
  environment.variables = {
    # As of ROCm 4.5, AMD has disabled OpenCL on Polaris based cards. So this is needed if you have a 500 series card. 
    ROC_ENABLE_PRE_VEGA = "1";
  };


  boot = {
    initrd.kernelModules = [ "amdgpu" ]; #needed for boot splash
    loader = {
       systemd-boot.enable = true;
       efi.canTouchEfiVariables = true;
     };

    plymouth = {
      #logo = ../../img/cat_boot.png;
      enable = true;
      theme = "plymouth-gif-theme";
      themePackages = [  (inputs.plymouth-gif-theme.packages.x86_64-linux.default.override {logo = ../../img/cat-funny-cat.gif;})  ];
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
      rebuild = "sudo nixos-rebuild switch --flake /home/celeste/flake#celeste-laptop ; 
                 hyprctl reload ;
                 makoctl reload";
      update = "pushd /home/celeste/flake; sudo nix flake update; popd";
    };

    ohMyZsh = {
      enable = true;
      plugins = [ "git" 
                  "direnv"     
                ];
      theme = "alanpeabody";
    };
  };

  users.users.celeste.shell = pkgs.zsh;

  networking.hostName = "celeste-laptop";

  #networking.networkmanager.enable = true;

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
