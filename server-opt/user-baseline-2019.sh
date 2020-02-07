#!/bin/sh
# Use it under a normal user.

set -eu

mkdir -p ~/bin ~/repo ~/tmp ~/src


# Download my bots
cd ~/repo/
git clone https://github.com/mdrights/Myscripts
git clone https://github.com/mdrights/csobot
git clone https://github.com/mdrights/csobot
git clone https://github.com/matrix-org/matrix-python-sdk
git clone https://github.com/mdrights/tiny-matrix-bot
cd tiny-matrix-bot/
ln -s ../matrix-python-sdk/matrix_client
cd -

cp Myscripts/dotfiles/bashrc ~/.bashrc

# Make a startup script for my bot.
echo "#!/bin/sh
 
 $HOME/repo/tiny-matrix-bot/tiny-matrix-bot.py &
 
" > ~/bin/run-csobot.sh

exit
