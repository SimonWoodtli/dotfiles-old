# Setup Neomutt

## Instructions

1. create gpg key: `gpg --full-gen-key`
2. create encrypted passphrase: `pass init [gpgEmail]` (creates ~/.password-store/)
or `pass init [gpgID]`
3. install [mutt-wizzard]
4. add your emails with `mw -a yourEmail`
5. setup `notmuch` to search mails with ctrl-f: `notmuch new`
6. setup cronjob to sync mail every 10min: `mw -t 10` check:  `crontab -l`

## Issue mailto from webbrowser

If you set xdg-open to open neomutt you need to invoke it with `alacritty -e /usr/bin/neomutt -E %U` in a neomutt.desktop file.However invoking alacritty like this will actually open a login shell which is not able to parse my bashrc early enough. That means no environment variables are set. The thing is that in ssh sessions bashrc gets loaded (I guess because I already started an interactive non-login shell). And if I open a login shell with `CTRL-ALT-F3` bashrc gets loaded as well.
So that is why I think it actually works like it should but bashrc just doesn't get loaded quick enough. A keyboard shortcut to test this: `alacritty --hold -e env` which shows only a bare minimum of the enviroment is being loaded.

TODO: Figure out how to read bashrc before login shell even starts.
* Simply reading bashrc in .profile or .bash_profile won't suffice: `[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"`

The consequence of this is that nano gets started in this instance. A quick fix is to either:
1. add this to muttrc: `set editor="/usr/bin/vim"`
2. or add this to .bash_profile: `export EDITOR=vim` (preferred)

[mutt-wizzard]: <https://github.com/SimonWoodtli/dotfiles/blob/main/bin/install/popOS/install-mutt>

Related:

* <https://github.com/LukeSmithxyz/mutt-wizard>
* <xdg link>
