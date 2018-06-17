echo "Reading .zshrc"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export LC_CTYPE=sv_SE.UTF-8
export LC_ALL=sv_SE.UTF-8

source /usr/local/share/zsh/site-functions

# Ruby

eval "$(rbenv init -)"

be () { bundle exec $* }
alias be=be

case $(uname -s) in
    Darwin*)
        echo "Darwin"
        # MacOS
        alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
        ;;
    Linux*)
        echo "Linux"
        ;;
esac

# Pass

alias pass-lannisters='export PASSWORD_STORE_DIR=$HOME/.password-store-lannisters'
alias pass-reset='export PASSWORD_STORE_DIR=$HOME/.password-store/'

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
