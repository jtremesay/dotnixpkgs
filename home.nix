{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  # Yup, it's me 
  home.username = "jtremesay";
  home.homeDirectory = "/home/${config.home.username}";

  # Define environment variable
  home.sessionPath = ["$HOME/.local/bin"];
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
    VISUAL = config.home.sessionVariables.EDITOR;

    # Disable fish greeting
    fish_greeting = "";
  };
  xdg.enable = true;


  # Install some packages
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.git = {
    enable = true;
    userEmail = "jonathan.tremesaygues@slaanesh.org";
    userName = "Jonathan Tremesaygues";
    extraConfig = {
        init = {
            defaultBranch = "main";
        };
        pull = {
            rebase = true;
        };
    };
  };
  programs.neovim = {
    enable = true;
    coc = {
        enable = true;
    };
    extraPython3Packages = (ps: with ps; [ python-lsp-server ]);
    plugins = with pkgs.vimPlugins; [
        {
            plugin = nvim-base16;
            config = ''
set background = "dark"
colorscheme base16-monokai
let base16colorspace = 256  " Access colors present in 256 colorspace
set termguicolors
            '';
        }
        {
          plugin = nerdtree;
          config = ''
map <C-n> :NERDTreeToggle<CR>
          '';
        }
        {
          plugin = vim-airline;
          config = ''
let g:airline_theme='base16_helios'
let g:airline#extensions#ale#enabled = 1
          '';
        }
        vim-airline-themes
    ];
    extraConfig = ''
" Use actual tab chars in Makefiles.
autocmd FileType make set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab

" Indent size 2 for YAML
autocmd FileType yaml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" For everything else, use a tab width of 4 space chars.
set tabstop=4      " The width of a TAB is set to 4.
                   " Still it is a \t. It is just that
                   " Vim will interpret it to be having
                   " a width of 4.
set shiftwidth=4   " Indents will have a width of 4.
set softtabstop=4  " Sets the number of columns for a TAB.
set expandtab      " Expand TABs to spaces.

set mouse=a        " Enable mouse stroll
set number         " Enable line numbering
set colorcolumn=80 " Add a ruler
    '';
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  home.packages = [
    pkgs.thunderbird
  ];
 
  # Xsession
  # Could (should ?) be handled by home-manager
  # https://nix-community.github.io/home-manager/options.html#opt-xsession.enable
  home.file.xsession = {
    executable = true;
    source = ./dot_xsession;
    target = ".xsession";
  };

  # XResources (colors and font setting of the terminal)
  home.file.xresources = {
    source = ./dot_xresources;
    target = ".Xresources";
  };

  # i3
  xdg.configFile.i3_config = {
    source = ./i3_config;
    target = "i3/config";
  };
  xdg.configFile.i3status_config = {
    source = ./i3status_config;
    target = "i3status/config";
  };
}
