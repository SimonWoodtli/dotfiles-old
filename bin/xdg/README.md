# Set default programs for your OS

`xdg-open` handles which file type opens which GUI app. Usually terminal apps use 
environment variables.

## Important file locations

* local .desktop files: `~/.local/share/applications`
* global .desktop files: `/usr/share/applications`
* xdg-mime local file: `~/.config/mimeapps.list`
* xdg-mime global file: `/usr/share/applications/defaults.list` 

## Default GUI file explorer

* Make Thunar default file explorer: `xdg-mime default Thunar.desktop inode/directory`
* If your app doesn't already have it make sure there is a foo.desktop file in `~/.local/share/applications`.

## Default editor

* launch from terminal: you need to export \$EDITOR and \$VISUAL.
Global: set `sudo update-alternatives --config editor` to vim.
Local: set `select-editor` to vim.
* launch from GUI: issue: it opens in a gnome-terminal quick fix: change 
vim.desktop to exec with Alacritty (not recommended)
and `xdg-mime default vim.desktop text/plain`

## Default audio/video Player

* can be set from GUI settings or with many filetypes manually with `xdg-mime`

## Default mail

* run setup and select from GUI settings: Mutt
* checkout [instructions for mutt]

## Default browser

* can bet set from GUI settings

Related:

* <https://unix.stackexchange.com/questions/36380/how-to-properly-and-easily-configure-xdg-open-without-any-environment>

Tags:

    #linux #xdg-open #defaultApp #email #browser #pdf
