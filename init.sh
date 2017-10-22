#!/bin/sh
echo "install from standard dnf repos"
sudo dnf update -y
sudo dnf install vim chromium java-1.8.0-openjdk java-devel git-gui tmux screen curl w3m ncurses-compat-libs kernel-devel kernel-headers xcopy unixODBC-devel docker docker-client libappindicator nodejs npm -y

echo "setup tmux and vim"
cp .tmux.conf ~/.tmux.conf

echo "add microsoft repos to dnf"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/msprod.repo
sudo dnf check-update

echo "install ms dev tools"
sudo dnf install code mssql-tools -y

echo "download java dev tools"
wget -c http://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-javaee-linux.sh -P ~/Downloads/
wget -c http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.tar.gz -P ~/Downloads/
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.rpm" -P ~/Downloads/

echo "download productivity apps"
wget -c https://go.skype.com/skypeforlinux-64.rpm -P ~/Downloads/
wget -c https://downloads.slack-edge.com/linux_releases/slack-2.8.2-0.1.fc21.x86_64.rpm -P ~/Downloads/


echo "setup java dev tools"
sudo rpm -ivh ~/Downloads/jdk-8u144-linux-x64.rpm
tar -xvzf ~/Downloads/wildfly-10.1.0.Final.tar.gz -C ~/JEE/wildfly10/
chmod +x ~/Downloads/netbeans-8.2-javaee-linux.sh
~/Downloads/netbeans-8.2-javaee-linux.sh

echo "see http://wiki.netbeans.org/FaqRunningOnJre"

echo "setup JEE servers"
jeeinit.sh

echo "install productivity apps"
sudo rpm -ivh ~/Downloads/slack-2.8.1-0.1.fc21.x86_64.rpm
sudo rpm -ivh ~/Downloads/skypeforlinux-64.rpm

echo "setup environment"
touch ~/.Xauthority
xauth add ${HOST}:0 . $(xxd -l 16 -p /dev/urandom)
sudo ln -s /opt/mssql-tools/bin/sqlcmd /usr/local/bin/sqlcmd

