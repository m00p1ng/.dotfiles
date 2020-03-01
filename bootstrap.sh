# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install command line
cat brew-list.txt | xargs brew install
cat brew-cask.txt | xargs brew cask install

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


# Linking Config Files
ln -sf zsh/mooping.zsh-theme ~/.oh-my-zsh/themes/
ln -sf .agignore ~
ln -sf .gitconfig ~
ln -sf .gitignore_global ~
ln -sf .tmux.conf ~

echo "source ~/.dotfiles/zsh/.zshrc" > ~/.zshrc
echo ':set prompt "\ESC[1;34m%s\\n\ESC[0;31mλ> \ESC[m"' > ~/.ghci
