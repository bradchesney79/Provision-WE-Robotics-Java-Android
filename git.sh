#!/usr/bin/env bash

mkdir -p ~/.ssh/github/

# nohup ssh-agent -s &

ssh-keygen -t ed25519 -C "you@example.com" -f ~/.ssh/github/id_ed25519 -P ""

ssh-add ~/.ssh/github/id_ed25519

apt-get -y install git kdiff3


git config --global difftool.kdiff3 'kdiff3 "$LOCAL" "$REMOTE"'
git config --global diff.tool kdiff3
git config --global difftool.prompt false


git config --global mergetool.kdiff3 'kdiff3 "$BASE" "$LOCAL" "$REMOTE" -o "$MERGED"'
git config --global merge.tool kdiff3
git config --global mergetool.prompt false

git config --global user.email "you@example.com"
git config --global user.name "Your Name"

sudo curl -o /usr/local/bin/git-completion.bash https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/completion/git-completion.bash

echo "source /usr/local/bin/git-completion.bash" >> ~/.bashrc

sed -i s/#force_color_prompt=yes/force_color_prompt=yes/g ~/.bashrc


sudo curl -o /usr/local/bin/git-prompt.sh https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/completion/git-prompt.sh

echo "source /usr/local/bin/git-prompt.sh" >> ~/.bashrc

$prompt_text = <<<EOD
# Extract the current Git branch name
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

#
# \[\033[01;32m\] = Bold Green (User & Host)
# \[\033[01;34m\] = Bold Blue (Current working directory)
# \[\033[01;33m\] = Bold Yellow (Git branch name)

# \[\033[00m\] = Reset colors back to standard text




# Set PS1 prompt with a cyan directory, yellow Git branch, and a clean layout
PS1="\[\033[32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[01;33m\]\$(parse_git_branch)\[\033[00m\]\$ "
EOD;

echo $prompt_text >> ~/.bashrc

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/

sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get -y update

sudo apt-get -y install code


sudo add-apt-repository ppa:maarten-fonville/android-studio

sudo apt-get -y update

sudo apt-get install -y android-studio
