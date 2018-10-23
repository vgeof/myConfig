echo "Sauvegarde du fichier ~/.vimrc dans ~/.vimrc.old "
cp ~/.vimrc ~/.vimrc.old

echo  "Remplacement de ~/.vimrc"

cp .vimrc ~/.vimrc

echo "Copie des plugins"
cp .vim ~/ -r
