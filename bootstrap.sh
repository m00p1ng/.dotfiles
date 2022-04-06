function link_config () {
    # Linking Config Files
    ln -sf $PWD/zsh/mooping.zsh-theme $HOME/.oh-my-zsh/themes/
    ln -sf $PWD/zsh/zsh_plugins.txt $HOME/.zsh_plugins.txt
    ln -sf $PWD/.tmux.conf $HOME

    echo "source ~/.dotfiles/zsh/.zshrc" > $HOME/.zshrc
}

link_config
