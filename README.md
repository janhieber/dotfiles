# dotfiles

Clone it to home folder and execute the script to link the configs.
```bash
cd ~
git clone https://github.com/janhieber/dotfiles.git
./dotfiles/makelinks.sh
```
It'll ask you before deleting your files ;)

This is how the desktop looks like  
(yes I like pastel colors, the oldschool look and a minimal prompt)

![preview](https://raw.githubusercontent.com/janhieber/dotfiles/master/scrot.png)

# before you ask  
wm: i3  
bar: polybar  
terminal: urxvt  
shell: zsh

Colors are from [gruvbox](https://github.com/morhetz/gruvbox).  
I got i3 and polybar to use the colors from [.Xressources](/home/.Xresources),
spares some work when changing colors.

# lockscreen
I have written a [script](/home/.bin/i3lock-fancy.sh) that makes a blurry
screenshot and uses that for lockscreen.

If you want automatic locking before suspend, then copy
[this](/root/etc/systemd/system/slock.service) systemd
service to your system and enable it:
```bash
systemctl daemon-reload
systemctl enable slock.service
```
Because the script takes some time to blur the screen,
it is designed to let systemd wait until the screen is locked
before suspending the system.

# EFISTUB boot
Look [here](/root/etc/systemd/system) for the service files
and [here](/home/scripts/efistub_bootentry.sh) for the script to
make the UEFI entry. The instructions are in the script.

# autorandr
To automatically change display configuration
when connecting display, follow this:

Copy [40-monitor-hotplug.rules](/root/etc/udev/rules.d/40-monitor-hotplug.rules) to
your system and change my username to yours. Then reload the
udev rules with ``udevadm control --reload``.

Now copy [autorandr.sh](/home/.bin/autorandr.sh) to your system
and change my username again.

Download [autorandr](https://github.com/phillipberndt/autorandr) with
```bash
sudo wget https://raw.githubusercontent.com/phillipberndt/autorandr/master/autorandr.py -O /usr/local/bin/autorandr
sudochmod +x /usr/local/bin/autorandr
```
Warning: The other versions in AUR are old and not maintained! Use this one!

With ``arandr`` or somethign else, configure your default screen layout (eg. only laptop screen). Then save the config with ``autorandr -s default``.  
Now, everytime you have a new display connected, set it up with xrandr or arandr
and save the profile with a specific name, example: ``autorandr -s tv``

When your display adapters change, udev calls autorandr, which configures your
screens!

