echo "Reading .zshrc"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export LC_CTYPE=sv_SE.UTF-8
export LC_ALL=sv_SE.UTF-8

source /usr/local/share/zsh/site-functions

TIMEFMT='%J   %U  user %S system %P cpu %*E total'$'\n'\
'avg shared (code):         %X KB'$'\n'\
'avg unshared (data/stack): %D KB'$'\n'\
'total (sum):               %K KB'$'\n'\
'max memory:                %M MB'$'\n'\
'page faults from disk:     %F'$'\n'\
'other page faults:         %R'

# Erlang

export CRACKLIB_DICTPATH=/usr/local/share/cracklib-words
export ERL_INETRC=${HOME}/.inetrc

case $(uname -s) in
    Darwin*)
        echo "Darwin"
        # MacOS
        alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
        ;;
    Linux*)
        echo "Linux"
        SSH_AGENT_ENV=$HOME/.ssh/agent-environment
        function start-ssh-agent {
                 /usr/bin/ssh-agent | sed 's/^echo/#echo/' >! $SSH_AGENT_ENV
                         chmod 600 $SSH_AGENT_ENV
                                 source $SSH_AGENT_ENV > /dev/null
        }

        if [ -f $SSH_AGENT_ENV ] ; then
           source $SSH_AGENT_ENV > /dev/null
           ps $SSH_AGENT_PID | grep -q ssh-agent || {
              start-ssh-agent
           }
        else
           start-ssh-agent
        fi

        export EDITOR=ec
        alias emacs="TERM=xterm-24bits emacs -nw"
        ;;
esac

# Ruby

eval "$(rbenv init -)"

be () { bundle exec $* }
alias be=be

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

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

disable -r time       # disable shell reserved word
alias time='time -p ' # -p for POSIX output
