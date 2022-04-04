function link_config () {
    # Linking Config Files
    ln -sf $PWD/zsh/mooping.zsh-theme $HOME/.oh-my-zsh/themes/
    ln -sf $PWD/zsh/zsh_plugins.txt $HOME/.zsh_plugins.txt
    ln -sf $PWD/.agignore $HOME
    ln -sf $PWD/.gitconfig $HOME
    ln -sf $PWD/.gitignore_global $HOME
    ln -sf $PWD/.tmux.conf $HOME
    ln -sf $PWD/.ripgreprc $HOME
    ln -sf $PWD/.ssh/config $HOME/.ssh
}

function other_config () {
    echo "source ~/.dotfiles/zsh/.zshrc" > $HOME/.zshrc
    echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.zshrc
    echo ':set prompt "\ESC[1;34m%s\\n\ESC[0;31mλ> \ESC[m"' > $HOME/.ghci
}

link_config
other_config
