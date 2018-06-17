#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Browser
#
echo "Reading .zprofile"
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export EDITOR='nano'
export VISUAL='nano'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

export ORIG_PATH=$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"

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
kred_otp
# Ruby

case $(uname -s) in
    Darwin*)
        # MacOS
        export PATH="$HOME/.rbenv/shims:$PATH"
        export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
        export PATH=$PATH:/Library/TeX/texbin
        ;;
    Linux*)
        ;;
esac
