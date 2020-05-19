# retro2png

Utility to take snapshots of the Raspberry Pi screen and save it as PNG files. Works with keyboard and game controller hotkeys in RetroPie, Recalbox, Blast16, X11, console etc., and from the command line.

Many thanks to Andrew Duncan and Stefan Tomanek for their great utilities [raspi2png](https://github.com/AndrewFromMelbourne/raspi2png) and [Triggerhappy](https://github.com/wertarbyte/triggerhappy)!

## New Features
- Saves default to the "~/Pictures" folder
- Triggered with fully configurable keyboard and game controller hotkey combinations, as well as from the command line
- Up to 99 auto-incremented standard "snapshot_X.png" file names in all specified save folders
- Save folder easiliy specified anywhere behind the ```retro2png``` command without need of flags, or together with other flags
- Keyboard and game controller hotkeys are fully and easily configurable, and works from most applications and user interfaces 

## Usage
- Default keyboard hotkey trigger combination: ```"r+2+p"```
- Default controller hotkey trigger combination: ```"Mode/PS+DPAD_UP"```
- From the command line:
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

Run this command through terminal or CLI screen on most systems.

```curl -sL https://raw.githubusercontent.com/Vegz78/retro2png/master/installer.sh | bash -```

## Special Simple Install for Blast16

Due to some missing libraries and certificates, tested on fresh Blast 16 v.1.0.18.
<br>ESC key to get to terminal from Blast16 to run this command.

```wget --no-check-certificate https://raw.githubusercontent.com/Vegz78/retro2png/master/installer_blast16.sh&&chmod +x ./installer_blast16.sh&&./installer_blast16.sh```

## Configuring the Gamepad and Keyboard Hotkeys
- To observe gamepad and keyboard button/key press codes, run(exit with CTRL+C):
```thd --dump /dev/input/event*```
- Edit(sudo) the file /etc/triggerhappy/triggers.d/retro2png.conf, example:
```


## Manual Building and Installing

You will need to install libpng before you build the program. On Raspbian:

```
# 1. Install dependencies
sudo apt update
sudo apt install -y libpng-dev git-core triggerhappy

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
retro2png -H
```


