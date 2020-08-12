# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "slaptop"; # Define your hostname.
  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  # Laptop has no ethernet port
  networking.interfaces.eth0.virtual = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Fonts
  fonts.fonts = with pkgs; [
    font-awesome # Needed for waybar icons
    inconsolata
    lato
    national-park-typeface
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-emoji-blob-bin
    noto-fonts-extra
  ];
  fonts.fontconfig.defaultFonts.emoji = [ "Blobmoji" ];
  fonts.fontconfig.defaultFonts.sansSerif = [ "Lato" ];
  fonts.fontconfig.defaultFonts.monospace = [ "Inconsolata" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    alacritty
    audacity
    blackbird
    calibre
    cowsay
    deja-dup
    figlet
    firefox
    firefox-wayland
    frotz
    geoclue2
    gimp
    git
    gnome3.gnome-characters
    gnupg1
    inetutils
    inform6
    kitty
    lesspass-cli
    libreoffice
    mosh
    mpv
    mupdf
    neofetch
    p7zip
    pidgin
    podman
    purple-lurch
    python3
    sfrotz
    thunderbird
    tldr
    toilet
    tor-browser-bundle-bin
    tree
    unzip
    vim
    vscodium
    wget
    wl-clipboard

    #Unfree packages
    spotify
    steam
  ];

  # Enable VirtualBox for virtualization
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "intl";
  
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable desktop environments.
  services.xserver.displayManager.sddm.enable = true;
  programs.sway.enable = true;
  programs.sway.extraPackages = with pkgs; [
    gnome3.zenity
    grim
    light
    mako
    redshift-wlr
    rofi
    swayidle
    swaylock
    waybar
    xwayland
  ];
  programs.sway.wrapperFeatures.gtk = true;
  programs.sway.extraSessionCommands = ''
    export GTK_THEME=Blackbird
    export GTK_ICON_THEME=Tango
    export MOZ_ENABLE_WAYLAND=1
  '';
  programs.waybar.enable = true;
  programs.light.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.xfce.thunarPlugins = [
    pkgs.xfce.thunar-archive-plugin
    pkgs.xfce.thunar-volman
  ];
  services.redshift.package = pkgs.redshift-wlr;
  services.redshift.enable = true;
  location.provider = "geoclue2";
  services.actkbd.enable = true;

  # Let desktop environments handle the power key
  services.logind.extraConfig = "HandlePowerKey=ignore";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lunasspecto = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "vboxusers" "video" "wheel" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

