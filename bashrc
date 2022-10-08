########################################################################
#______  ___   _____ _   _ ______  _____
#| ___ \/ _ \ /  ___| | | || ___ \/  __ \
#| |_/ / /_\ \\ `--.| |_| || |_/ /| /  \/
#| ___ \  _  | `--. \  _  ||    / | |
#| |_/ / | | |/\__/ / | | || |\ \ | \__/\
#\____/\_| |_/\____/\_| |_/\_| \_| \____/
#
########################################################################

## source bashrc config files
for shell in $HOME/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/*.sh; do
  source $shell
done
##this must be at the end of bashrc for sdkman to work
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
