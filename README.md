# dotfiles

Clone it to home folder and execute the script to link the configs.
```bash
cd ~
git clone https://github.com/janhieber/dotfiles.git
./dotfiles/makelinks.sh
```
It'll ask you before deleting your files ;)

This is how the desktop looks like.  
![preview](https://raw.githubusercontent.com/janhieber/dotfiles/master/scrot.png)

# before you ask  
wm: i3  
bar: polybar  
terminal: urxvt  
shell: zsh

# lockscreen
I have written a [script](/home/.bin/i3lock-fancy.sh) that makes a blurry
screenshot and uses that for lockscreen.

If youw ant automatic locking before suspend, the copy
[this](/root/etc/systemd/system/slock.service) systemd
service to your system and enable it with
```bash
systemctl daemon-reload
systemctl enable slock.service
```

