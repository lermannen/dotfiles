echo "Reading .zshrc"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export LC_CTYPE=sv_SE.UTF-8
export LC_ALL=sv_SE.UTF-8

export ORIG_PATH="~/.rbenv/shims:${PATH}"

export CRACKLIB_DICTPATH=/usr/local/share/cracklib-words
#export ERL_INETRC=${HOME}/.inetrc

eval "$(rbenv init -)"

alias emacs="/usr/local/Cellar/emacs/24.5/Emacs.app/Contents/MacOS/Emacs -nw"

function r15b03-1()
{
    export PATH="${HOME}/src/klarna/otp-bin/install/R15B03-1/bin:${ORIG_PATH}"
    echo "Erlang: " `which erl`
}

function stderl()
{
    export PATH="${ORIG_PATH}"
    echo "Erlang: " `which erl`
}

# Use Kred Erlang by default, or face the consequences!
r15b03-1
export PATH="$HOME/.rbenv/shims:$PATH"

be () { bundle exec $* }
alias be=be