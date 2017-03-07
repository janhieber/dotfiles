read -p "Are you sure? type YES: " yn
[ "$yn" != "YES" ] && exit 1

if [ "$HOME" != "$(pwd)" ]
then
    echo "execute in home!"
fi
exit 0
echo ".dotfiles" >> .gitignore
git clone --bare git@github.com:janhieber/dotfiles.git $HOME/.dotfiles
function config {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no

