# dotfiles

The way I manage this is described [here](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

Short description:
- the dotfiles repo is cloned as bare repo in ``~/.dotfiles``
- then you tell git that the work tree is your $HOME
- untracked files are simply ignored
- to track a file, simply add it to the repo
- to make this easier, an alias is used: ``alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"``
- stage all changes with ``config add -u``

```bash
git clone --bare https://github.com/janhieber/dotfiles.git .dotfiles
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
config checkout origin master
```

