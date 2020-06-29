{config, pkgs, lib, ...}:
{
    programs.fzf = {
        enable = true;
    };
    programs.keychain = {
        enable = true;
        keys = [ "id_rsa" "id_ed25519" ];
    };
    programs.pazi = {
        enable = true;
    };

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        history = {
            save = 1000;
            size = 1000;
        };


        shellAliases = {
            ls = "exa";
        };
        
        oh-my-zsh = {
            enable = true;
            plugins = [ "git" "sudo" "colored-man-pages" "colorize" ];
        };

        initExtra = ''
            if [ -f "$HOME/.p10k.zsh" ]; then
                source "$HOME/.p10k.zsh"
            fi

            function t {
                cd $(mktemp -d $XDG_RUNTIME_DIR/$1.XXXX)
            }
            GITSTATUS_DAEMON=${pkgs.gitAndTools.gitstatus}/bin/gitstatusd
            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
            #ZSH_THEME=powerlevel9k
        '';
    };
}