#!/bin/bash
# BRIEF: This script is used to make a NEW instance set up to work.
# AUTHOR: root

# Automatic Security Updates
## Done.

# Add a Limited User Account

USER='linus'
useradd -G sudo,users -s /bin/bash $USER

chmod 700 /home/$USER/
mkdir -p -m 0700 /home/$USER/.ssh
cp ~/.ssh/authorized_keys /home/$USER/.ssh/authorized_keys
chown ${USER}. /home/$USER/.ssh/authorized_keys

# Harden SSH Access
## SSH Daemon Options

SSHD_CFG="/etc/ssh/sshd_config"
echo -e "\n ## My settings ## \nPermitRootLogin no \nPasswordAuthentication no \nX11Forwarding yes" >> $SSHD_CFG

# Restart it when you import your SSH key:
# systemctl restart sshd

# Add backports and Update packages
echo "deb http://deb.debian.org/debian buster-backports main" >> /etc/apt/sources.list
apt update && apt upgrade -y

# Use Fail2Ban and other tools.
apt-get install -y fail2ban nodejs nginx git wget w3m atop htop tmux gpg software-properties-common

# Add third-party repo: Tor.
echo "
deb https://deb.torproject.org/torproject.org buster main
deb-src https://deb.torproject.org/torproject.org buster main
" > /etc/apt/sources.list.d/torproject.list

wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -

apt update
apt install -y tor deb.torproject.org-keyring

# Add third-party repo: Docker.
curl -fsSL https://download.docker.com/linux/debian/gpg |apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

apt update
apt install -y docker-ce docker-ce-cli containerd.io
usermod -aG docker $USER

# Remove Unused Network-Facing Services
stemctl stop exim4
systemctl disable exim4

# Pull my dotfiles
git clone https://github.com/mdrights/Myscripts.git /home/$USER/repo/

# Configure a Firewall
/home/$USER/repo/Myscripts/iptables-scripts/iptables.vps.sh start

# Install GitLab runner:
/home/$USER/repo/Myscripts/server-opt/gitlab-runner-download.deb.sh

cat <<EOF | sudo tee /etc/apt/preferences.d/pin-gitlab-runner.pref
Explanation: Prefer GitLab provided packages over the Debian native ones
Package: gitlab-runner
Pin: origin packages.gitlab.com
Pin-Priority: 1001
EOF

apt update
apt install -y gitlab-runner

# Install OSSEC:
# wget -q -O - https://www.atomicorp.com/RPM-GPG-KEY.atomicorp.txt |apt-key add -
# echo "deb https://updates.atomicorp.com/channels/atomic/debian buster main" >>  /etc/apt/sources.list.d/atomic.list
# apt update && apt install -y ossec-hids-server

# Harden the kernel.
echo "        #### Set by root at $(date) ####
net.ipv4.conf.default.rp_filter=1
net.ipv4.conf.all.rp_filter=1
net.ipv4.tcp_syncookies=1
net.ipv4.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0
net.ipv4.conf.all.log_martians = 1
" > /etc/sysctl.d/90-hardening.conf

/sbin/sysctl --system


