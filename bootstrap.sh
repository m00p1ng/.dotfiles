function install_brew () {
    # Install brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # Install command line
    cat brew.txt | xargs brew install
    cat brew-cask.txt | xargs brew cask install
}

function install_zsh () {
    # Install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # Install zsh plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

function link_config () {
    # Linking Config Files
    ln -sf $PWD/zsh/mooping.zsh-theme $HOME/.oh-my-zsh/themes/
    ln -sf $PWD/.agignore $HOME
    ln -sf $PWD/.gitconfig $HOME
    ln -sf $PWD/.gitignore_global $HOME
    ln -sf $PWD/.tmux.conf $HOME
    ln -sf $PWD/.ripgreprc $HOME
}

function other_config () {
    echo "source ~/.dotfiles/zsh/.zshrc" > ~/.zshrc
    echo ':set prompt "\ESC[1;34m%s\\n\ESC[0;31mλ> \ESC[m"' > ~/.ghci
}

install_brew
install_zsh
link_config
other_config
