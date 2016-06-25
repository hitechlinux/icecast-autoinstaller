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
  
    myiceuser = User Which you will login with Filezilla to upload .mp3 into music/ folder.
  
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
