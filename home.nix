{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.acato = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.11";
    /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
    programs.git = { 
      enable = true; 
      userName = "andrewdcato"; 
      userEmail = "andrewdcato@gmail.com"; 
    };

    programs.neovim = { 
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      extraLuaConfig = ''
      	vim.g.mapleader = ' ';

        local options = {
          number = true,
          relativenumber = true,
          showmatch = true,
          colorcolumn = '120',
          termguicolors = true,
          smartindent = true,

          -- Use 2 spaces instead of tabs 
          tabstop = 2,
          softtabstop = 2,
          shiftwidth = 2,
          expandtab = true,

          -- Search tweaks
          ignorecase = true,
          smartcase = true,

          -- wrapping
          textwidth = 0;
          wrapmargin = 0;
          wrap = true;
          linebreak = true;
        };

        for key, value in pairs(options) do
          vim.opt[key] = value;
        end
      '';
    }; 

    programs.starship = {
      enable = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        # add_newline = false;

        # character = {
        #   success_symbol = "[➜](bold green)";
        #   error_symbol = "[➜](bold red)";
        # };

        # package.disabled = true;
      };
    };

    programs.zsh = {
      enable = true;

      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = ["git"];
        theme = "starship";
      };

      initExtra = ''
        eval "$(starship init zsh)"
      '';
    };


    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;

      extraConfig = ''
        local config = {};

        config.color_scheme = 'Catppuccin Macchiato';
        config.enable_scroll_bar = false;

        config.window_background_opacity = 0.87;
        config.window_padding = {
          left = 5,
          right = 0,
          top = 0,
          bottom = 0,
        };

        config.line_height = 1.05;

        return config;
      '';
    };
  };
}
