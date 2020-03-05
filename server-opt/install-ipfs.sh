#!/bin/sh

set -eu

if [ $UID -ne 0 ]; then
    echo "Oops, you are root. Quit."
    exit 1
fi

useradd -m -G users -s /bin/bash ipfs ||true

cp /home/linus/.bashrc /home/ipfs/
chown ipfs. /home/ipfs/.bashrc
echo 'export IPFS_PATH=/opt/go-ipfs/ipfsrepo' >> /home/ipfs/.bashrc                                                                   

# Downloading
cd /opt/

wget -c https://dist.ipfs.io/go-ipfs/v0.4.23/go-ipfs_v0.4.23_linux-amd64.tar.gz                                                       
tar xzvf go-ipfs_v0.4.23_linux-amd64.tar.gz

mkdir -p go-ipfs/ipfsrepo

chown -R ipfs:users go-ipfs

rm go-ipfs_v0.4.23_linux-amd64.tar.gz

cd -

cp /home/linus/repo/csobot/ipfs.service /etc/systemd/system/ 
cp /home/linus/repo/tiny-matrix-bot/tiny-matrix-bot.service /etc/systemd/system/

exit

