function install_brew () {
    # Install brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    # set brew path
    echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.zshrc
    eval $(/opt/homebrew/bin/brew shellenv)

    # Install command line
    cat brew.txt | xargs brew install
}

function install_zsh () {
    # Install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function link_config () {
    # Linking Config Files
    ln -sf $PWD/zsh/mooping.zsh-theme $HOME/.oh-my-zsh/themes/
    ln -sf $PWD/zsh/zsh_plugins.txt $HOME/.zsh_plugins.txt
    ln -sf $PWD/.agignore $HOME
    ln -sf $PWD/.gitconfig $HOME
    ln -sf $PWD/.gitignore_global $HOME
    ln -sf $PWD/.tmux.conf $HOME
    ln -sf $PWD/.ripgreprc $HOME
}

function other_config () {
    echo "source ~/.dotfiles/zsh/.zshrc" > $HOME/.zshrc
    echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.zshrc
    echo ':set prompt "\ESC[1;34m%s\\n\ESC[0;31mλ> \ESC[m"' > $HOME/.ghci
}

function link_command () {
    mkdir -p $PWD/commands
    git clone git@github.com:m00p1ng/kattis-cli.git $PWD/commands/kattis-cli
}

install_brew
install_zsh
link_config
link_command
other_config
