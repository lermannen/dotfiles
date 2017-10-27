echo "Reading .zshrc"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export LC_CTYPE=sv_SE.UTF-8
export LC_ALL=sv_SE.UTF-8

export ORIG_PATH=$PATH

export PATH="$HOME/bin:$PATH"
source /usr/local/share/zsh/site-functions

# Erlang

export CRACKLIB_DICTPATH=/usr/local/share/cracklib-words
export ERL_INETRC=${HOME}/.inetrc

function kred_otp()
{
    export PATH="/usr/local/otp/bin:${ORIG_PATH}"
    echo "Erlang: " `which erl`
}

function stderl()
{
    export PATH="${ORIG_PATH}"
    echo "Erlang: " `which erl`
}

# Ruby

eval "$(rbenv init -)"

be () { bundle exec $* }
alias be=be

case $(uname -s) in
    Darwin*)
        echo "Darwin"
        # MacOS
        alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
        export PATH="$HOME/.rbenv/shims:$PATH"
        export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
        export PATH=$PATH:/Library/TeX/texbin
        ;;
    Linux*)
        echo "Linux"
        ;;
esac

# Pass

alias pass-lannisters='export PASSWORD_STORE_DIR=$HOME/.password-store-lannisters'
alias pass-reset='export PASSWORD_STORE_DIR=$HOME/.password-store/'
