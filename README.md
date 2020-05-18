# retro2png

Utility to take a snapshot of the Raspberry Pi screen and save it as a PNG file. 

Updated to:
- save to default "~/Pictures" folder with up to 99 auto-incremented standard "snapshot_X.png" file names
- trigger with keyboard hotkey combination "r+2+p" and controller hotkey combination "Mode/PS+DPAD_UP" in RetroPie etc.

```
    Usage: raspi2png [dirname] [--pngname name] [--width <width>] [--height <height>] [--compression <level>] [--delay <delay>] [--display <number>] [--stdout] [--help]

    dirname - path of png file to create (default is /home/pi/Pictures)
    --pngname,-p - path and/or name of png file to create (default is snapshot.png)
    --height,-h - image height (default is screen height)
    --width,-w - image width (default is screen width)
    --compression,-c - PNG compression level (0 - 9)
    --delay,-d - delay in seconds (default 0)
    --display,-D - Raspberry Pi display number (default 0)
	--stdout,-s - write file to stdout
    --help,-H - print this usage information
```
## Simple Install

Run this command through terminal or CLI screen.

```curl -sL https://raw.githubusercontent.com/Vegz78/retro2png/master/installer.sh | bash -```

## Manual Building and Installing

You will need to install libpng before you build the program. On Raspbian

```
# 1. Install dependencies
sudo apt update&&sudo apt-get -y install libpng-dev git-core triggerhappy

# 2. Clone git to home folder
cd ~
git clone https://github.com/Vegz78/retro2png.git
cd retro2png

# 3. Compile and install retro2png
make
sudo make install

# 4. Setup Triggerhappy
sed -i "s/pi/$USER/g" ./triggerhappy.service
sudo cp -f ./triggerhappy.service /lib/systemd/system/triggerhappy.service
sudo cp -f ./retro2png.conf /etc/triggerhappy/triggers.d/retro2png.conf  #Raspbian installs triggerhappy as default, but optional, so when changing user here, the Shift key on boot to disable the on-demand scaling governor might not work after this
sudo systemctl disable triggerhappy.socket  #This socket prevents triggerhappy from starting correctly, ref: https://github.com/wertarbyte/triggerhappy/issues/22
sudo systemctl daemon-reload
sudo systemctl enable triggerhappy.service
sudo systemctl restart triggerhappy.service
sudo systemctl status triggerhappy.service  #From this you can check if the triggerhappy service now is running as your user

# 5. Clean up
cd ..
rm -fr retro2png
retro2png -H```


