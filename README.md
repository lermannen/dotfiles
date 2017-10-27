```
git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
https://github.com/sorin-ionescu/prezto

ln -s ~/.dotfiles/emacs.d/Cask ~/.emacs.d/Cask
ln -s ~/.dotfiles/emacs.d/init.el ~/.emacs.d/init.el
ln -s ~/.dotfiles/zprezto/modules/prompt/functions/prompt_alex_setup ~/.zprezto/modules/prompt/functions/prompt_alex_setup
ln -s ~/.dotfiles/zprezto/runcoms/zshrc ~/.zprezto/runcoms/zshrc
ln -s ~/.dotfiles/zpreztorc ~/.zpreztorc
ln -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/emacs.d/alex-spolsky-theme.el ~/.emacs.d/alex-spolsky-theme.el

brew install cask
cask install
```
