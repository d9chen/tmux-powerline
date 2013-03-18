cd "$(dirname "${BASH_SOURCE}")"
source themes/default.sh &>/dev/null

function writeTmuxConf() {
    echo 'set-option -g status on
set-option -g status-interval 2
set-option -g status-utf8 on
set-option -g status-justify "centre"
set-option -g status-left-length 60
set-option -g status-right-length 90
set-option -g status-left "#('`pwd`'/powerline.sh left)"
set-option -g status-right "#('`pwd`'/powerline.sh right)"
set-option -g status-bg colour'$TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR'
set-option -g status-fg colour'$TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR > ~/.tmux.conf
echo '
' >> ~/.zshrc
echo 'PS1="$PS1"''$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")' >> ~/.zshrc
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    writeTmuxConf
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
	writeTmuxConf
    fi
fi
