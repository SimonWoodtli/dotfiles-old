# Set Default Programs for your OS

`xdg-open` handles which file type opens which GUI app. Usually terminal apps use 
environment variables and most GUI apps should have a global .desktop file.

## Important File Locations

* local .desktop files: `~/.local/share/applications`
* global .desktop files: `/usr/share/applications` or `/usr/local/share/applications/`
* xdg-mime local file: `~/.config/mimeapps.list`
* xdg-mime global file: `/usr/share/applications/defaults.list` 

## How to set any Application as Default

1. Find out what mimetype it is: `mimetype foo.jpg` output: foo.jpg: image/jpeg
2. Find out location of config file and current default program: `XDG_UTILS_DEBUG_LEVEL=3 xdg-mime query default image/jpeg`
3. Make sure you either have a global or local .desktop file for the program you want to use as default
4. Set default program: `xdg-mime default imv.desktop image/jpeg`

## Default Editor

* Launch from terminal: you need to export \$EDITOR and \$VISUAL.
Global: set `sudo update-alternatives --config editor` to vim.
Local: set `select-editor` to vim.
* Launch from GUI: issue: it opens in a gnome-terminal quick fix: change 
vim.desktop to exec with your default terminal (not recommended)
and `xdg-mime default vim.desktop text/plain`

## Default PDF Reader

1. Add '-I' to the global mupdf.desktop files Exec variable: `sudo vim /usr/share/applications/mupdf.desktop`
2. Make Mupdf default reader: `xdg-mime default mupdf.desktop application/pdf`

## Default Audio/Video Player

* Can be set from GUI settings or with many filetypes manually with `xdg-mime`

## Default GUI File Explorer

* Make sure your App has either a local or global foo.desktop file before you run `xdg-mime default ...`
* If you want to change the File Explorer: (e.g. Thunar) `xdg-mime default Thunar.desktop inode/directory`

## Default Mail

* Run the 'setup' file in this folder. Then select from GUI settings: Mutt
* To install and setup Mutt: checkout [instructions for mutt]

## Default Browser

* Can bet set from GUI settings or with `xdg-mime`

Related:

* <https://unix.stackexchange.com/questions/36380/how-to-properly-and-easily-configure-xdg-open-without-any-environment>

Tags:

    #linux #xdg-open #defaultApp #email #browser #pdf
