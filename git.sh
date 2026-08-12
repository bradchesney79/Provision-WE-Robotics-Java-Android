#!/usr/bin/env bash

GITEMAIL=$(grep "^GITEMAIL=" config.txt | cut -d"=" -f2-)
GITNAME=$(grep "^GITNAME=" config.txt | cut -d"=" -f2-)

mkdir -p ~/.ssh/github/

# nohup ssh-agent -s &

ssh-keygen -t ed25519 -C $GITEMAIL -f ~/.ssh/github/id_ed25519 -P ""

ssh-add ~/.ssh/github/id_ed25519

sudo apt-get -y install git kdiff3


git config --global difftool.kdiff3 'kdiff3 "$LOCAL" "$REMOTE"'
git config --global diff.tool kdiff3
git config --global difftool.prompt false


git config --global mergetool.kdiff3 'kdiff3 "$BASE" "$LOCAL" "$REMOTE" -o "$MERGED"'
git config --global merge.tool kdiff3
git config --global mergetool.prompt false

git config --global user.email $GITEMAIL
git config --global user.name $GITNAME

sudo curl -o /usr/local/bin/git-completion.bash https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/completion/git-completion.bash

echo "source /usr/local/bin/git-completion.bash" >> ~/.bashrc

sed -i s/#force_color_prompt=yes/force_color_prompt=yes/g ~/.bashrc


sudo curl -o /usr/local/bin/git-prompt.sh https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/completion/git-prompt.sh

echo "source /usr/local/bin/git-prompt.sh" >> ~/.bashrc

#$prompt_text = <<<EOD
echo "

# Extract the current Git branch name
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}" | tee -a ~/.bashrc > /dev/null

# Colors from: https://misc.flogisoft.com/bash/tip_colors_and_formatting#colors2

# Set PS1 prompt with a green user@host, bold white directory, bold blue Git branch
# PS1="\[\033[32m\]\u@\h[\033[1;00m\]\[\033[01;01m\]:\w\[\033[01;34m\]\[$(parse_git_branch)\]\[\033[00m\]\$ "


#Green Blue Missing git branch
#PS1="\[\033[38;5;208m\]\u\[\033[38;5;237m\]@\[\033[38;5;208m\]\h\[\033[01;01m\]:\w\[\033[01;34m\]\[$(parse_git_branch)\]\[\033[00m\]\$ "

echo '

#North & South Colors in the terminal command prompt
PS1="\[\033[38;5;208m\]\u@\[\033[38;5;208m\]\h\[\033[1;00m\]\[\033[01;01m\]:\w\[\033[01;34m\]\[$(parse_git_branch)\]\[\033[00m\]\$ "' | tee -a ~/.bashrc

# echo "$prompt_text"
# echo $prompt_text | tee -a ~/.bashrc

echo "

===== github.com =============

Don't forget to add the pubkey to github under settings.

==============================" | tee -a ~/Desktop/post-install-resources.txt
