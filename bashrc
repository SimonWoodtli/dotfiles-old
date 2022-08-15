########################################################################
#______  ___   _____ _   _ ______  _____
#| ___ \/ _ \ /  ___| | | || ___ \/  __ \
#| |_/ / /_\ \\ `--.| |_| || |_/ /| /  \/
#| ___ \  _  | `--. \  _  ||    / | |
#| |_/ / | | |/\__/ / | | || |\ \ | \__/\
#\____/\_| |_/\____/\_| |_/\_| \_| \____/
#
########################################################################

source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/detection.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/utility-functions.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/export.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/path.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/settings.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/pager.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/cmd-prompt.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/vim.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/subprocs-suck.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/dircolors.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/completion.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/gruvbox-colors.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/colors-basic.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/ansi-escapes.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/termcap-colors.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/tldr-colors.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/python.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/golang.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/alias.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/functions.sh
source $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/personal.sh
##this must be at the end of bashrc for sdkman to work
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
