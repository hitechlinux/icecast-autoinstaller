#!/bin/bash
# ******************************************
# Script : IceCast2 + eZStream Auto Installer
# Developer: RAW A.K.A Jasht'sSerie
# ******************************************
# START

if [ "$1" ] || [ "$2" ]
then 

#Update System.
apt-get update -y
apt-get upgrade -y

#Create User.
useradd $1
mkdir /home/$1
mkdir /home/$1/music
chown -R $1:$1 /home/$1
echo $1:$2 | chpasswd -c MD5

#Required's.
apt-get install -y nano gcc make zip unzip build-essential screen pkg-config libxml2-dev icecast2 ezstream

#Req. For Stream.
mkdir ~/dfiles
cd ~/dfiles/
wget http://downloads.xiph.org/releases/ogg/libogg-1.3.2.zip
wget http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.5.zip
wget http://downloads.xiph.org/releases/libshout/libshout-2.4.1.tar.gz
wget http://downloads.xiph.org/releases/ezstream/ezstream-0.6.0.tar.gz

#Unzip Folders.
cd ~/dfiles/
unzip libogg-1.3.2.zip
unzip libvorbis-1.3.5.zip
tar xf libshout-2.4.1.tar.gz
tar xf ezstream-0.6.0.tar.gz
cd ~/

#Install Libogg.
cd ~/dfiles/libogg-1.3.2
./configure
make && make install

#Install LibVorbis.
cd ~/dfiles/libvorbis-1.3.5
./configure
make && make install

#Install Libshout.
cd ~/dfiles/libshout-2.4.1
./configure
make && make install

#Install EzStream.
cd ~/dfiles/ezstream-0.6.0
./configure
make && make install

#Clear.
cd ~/
rm -Rf ~/dfiles/

#Edit Icecast2 Settings.
rm -Rf /etc/default/icecast2
cat <<EOF > /etc/default/icecast2
# Defaults for icecast2 initscript
# sourced by /etc/init.d/icecast2
# installed at /etc/default/icecast2 by the maintainer scripts

#
# This is a POSIX shell fragment
#

# Full path to the server configuration file
CONFIGFILE="/etc/icecast2/icecast.xml"

# Name or ID of the user and group the daemon should run under
USERID=icecast2
GROUPID=icecast

# Edit /etc/icecast2/icecast.xml and change at least the passwords.
# Change this to true when done to enable the init.d script
ENABLE=true
EOF
	
#Set Icecast2 Password.
rm -Rf /etc/icecast2/icecast.xml
cat <<EOF > /etc/icecast2/icecast.xml
<icecast>
    <location>US</location>
    <admin>icemaster@localhost</admin>

    <limits>
        <clients>10000</clients>
        <sources>2</sources>
        <threadpool>5</threadpool>
        <queue-size>524288</queue-size>
        <client-timeout>30</client-timeout>
        <header-timeout>15</header-timeout>
        <source-timeout>10</source-timeout>
        <burst-size>65535</burst-size>
    </limits>

    <authentication>
        <source-password>$2</source-password>
        <relay-password>$2</relay-password>
        <admin-user>$1</admin-user>
        <admin-password>$2</admin-password>
    </authentication>

    <hostname>localhost</hostname>
    <listen-socket>
        <port>8000</port>
    </listen-socket>

    <fileserve>1</fileserve>

    <paths>
        <basedir>/usr/share/icecast2</basedir>
        <logdir>/var/log/icecast2</logdir>
        <webroot>/usr/share/icecast2/web</webroot>
        <adminroot>/usr/share/icecast2/admin</adminroot>
        <alias source="/" destination="/status.xsl"/>
    </paths>

    <logging>
        <accesslog>access.log</accesslog>
        <errorlog>error.log</errorlog>
        <loglevel>3</loglevel>
        <logsize>10000</logsize>
    </logging>

    <security>
        <chroot>0</chroot>
    </security>
</icecast>
EOF
	
#Creating Ezstream Config.
cat <<EOF > ~/ezstream_mp3.xml
<ezstream>
    <url>http://SERVER_IP:8000/stream</url>
    <sourcepassword>$2</sourcepassword>
    <format>MP3</format>
    <filename>/home/$1/music/playlist.txt</filename>
    <stream_once>0</stream_once>
    <svrinfoname>RADIO NAME</svrinfoname>
    <svrinfourl>http://RADIODOMAIN.com</svrinfourl>
    <svrinfogenre>RADIO Genre</svrinfogenre>
    <svrinfodescription>Radio, Dubstep, Mix, Trap, Remix, Chill.</svrinfodescription>
    <svrinfobitrate>128</svrinfobitrate>
    <svrinfochannels>2</svrinfochannels>
    <svrinfosamplerate>44100</svrinfosamplerate>
    <shuffle>1</shuffle>
    <svrinfopublic>0</svrinfopublic>
</ezstream>
EOF

#Restarting icecast.
service icecast2 restart

#End of The sotry.
echo "Installation Is Done!"
echo "Login with FileZilla Username: $1 Password: $2 "
echo "Upload .Mp3 Files On music/ folder"
fi
