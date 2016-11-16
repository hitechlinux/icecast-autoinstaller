# icecast-autoinstaller
IceCast2 + EzStream AutoInstaller Script.

Distro Supported : `Ubuntu 14.04, Debian 7, Zorin OS 11,`

1. Copy Project.
    
    $ **`cd ~/`**
  
    $ **`apt-get install git`**
    
    $ **`git clone https://github.com/hitechlinux/icecast-autoinstaller.git`**
    
    $ **`cd icecast-autoinstaller/`**
    
    $ **`chmod +x *`**

2. Start Installation

    $ **`./create.sh myiceuser mypassword`**

# K.B

    ./create.sh myiceuser mypassword
  
    myiceuser = User Which you will login with Filezilla to upload .mp3 into music/ folder. I Haven't Make this script to autoinstall Proftpd or Vsftpd, because maybe you have already installed it. so if you haven't install proftpd or vsftpd install it. IF you don't want you can use filezilla to upload in port 22 login as root and go at /home/myiceuser/music.
    Isn't needed to chmod/chown for as time as you will run stream as root. 
  
    mypassword = myiceuser password.

After you have upload some songs.mp3 you will need to create a playlist.txt with this command
  
    $ find /home/myiceuser/music/ -iname "*.mp3" > /home/myiceuser/music/playlist.txt
  
    change myiceuser with your username.
  
After those Steps Into root home you will find ezstream_mp3.xml Open and edit it

    $ cd ~/

    $ nano ezstream_mp3.xml

You can Read my Ezstream_Example.xml To know how this will work. After u'r Done Start Stream.

    $ sudo screen
 
    $ cd ~/
 
    $ ezstream -c ezstream_mp3.xml


Multi Stream in the same server?!
open new terminal tab, 

    $ cd ~/
    
    $ cp ezstream_mp3.xml
    
    $ nano ezstream_mp3.xml (Where is /stream change to /live)
    
    $ change /home/myuser/music/playlist.txt to /home/new-user/music/new-playlist.txt
    
    $ screen; ezstream -c ezstream_mp3.xml
