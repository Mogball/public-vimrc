cp -r .tmux ~/.tmux
cp .tmux.conf ~/.tmux.conf
cp .vimrc ~/.vimrc
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim/init.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
