# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Add ~/.local/bin to PATH if it exists
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Nvim
alias vim="nvim"

# Starship
if [ -f /usr/bin/starship ]; then
    eval "$(starship init bash)"
else
    echo "Starship not installed. Install it with 'sudo pacman -S starship'."
fi

# ls_extend
alias ll='ls_extended -lh'                                     # Long list format with human-readable sizes
alias la='ls_extended -A'                                      # List all files (including hidden, except . and ..)
alias lla='ls_extended -lAh'                                   # Long list format with human-readable sizes and all files
alias l='ls_extended -CF'                                      # List in columns with file type indicators
alias lr='ls_extended -R'                                      # Recursively list subdirectories
alias lt='ls_extended -lt'                                     # Sort by modification time (newest first)
alias ltr='ls_extended -ltr'                                   # Sort by modification time (oldest first)
alias lsize='ls_extended -lS'                                  # Sort by file size (largest first)
alias lss='ls_extended -sh'                                    # Show file sizes in human-readable format
alias lsd='ls_extended -d */'                                  # List only directories
alias lsg='ls_extended | grep'                                 # List and grep for a pattern
alias lsh='ls_extended -ld .*'                                 # List only hidden files
alias lsn='ls_extended -l | awk "{print \$9, \$6, \$7, \$8}"'  # List with only name and date

# Python
alias pyvenv="python -m venv .venv"
alias pyactivate="source .venv/bin/activate"

# Mount RClone
# systemctl --user start ~/.config/systemd/user/rclone-mount-*
