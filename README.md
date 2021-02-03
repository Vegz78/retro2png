# retro2png

Utility to take snapshots of the Raspberry Pi screen and save it as PNG files. Works with keyboard and game controller hotkeys in RetroPie, Recalbox, Blast16, X11, console etc., and from the command line.
[![](docs/Screenshot_Blast16_SNESES.jpg)](https://github.com/Vegz78/retro2png/blob/master/docs/Screenshot_Blast16_SNESES.jpg?raw=true)
(Screenshot of Blast16)

Many thanks to Andrew Duncan and Stefan Tomanek for their great utilities [raspi2png](https://github.com/AndrewFromMelbourne/raspi2png) and [Triggerhappy](https://github.com/wertarbyte/triggerhappy)!

Please also check out [this article about retro2png](https://translate.google.com/translate?hl=no&sl=no&tl=en&u=https%3A%2F%2Fretrospill.ninja%2F2020%2F05%2Fta-skjermbilde-av-blast16-sneses%2F)!

There are a couple of precompiled binaries for [download here](https://github.com/Vegz78/retro2png/tree/master/Binaries), but the simple [installation scripts](#simple-install-to-usrbin) are recommended, because they include the hotkey functionality and compile directly for the system it is executed on. 

## New Features
- Saves default to the "~/Pictures" folder when run with just ```retro2png``` without any command line parameters
- Triggered by keyboard and game controller hotkey combinations, as well as from the command line
- Up to 99 auto-incremented standard "retro2png_X.png" file names in all specified save folders
- Save folder easily specified anywhere behind the ```retro2png``` command without need of flags, or together with other flags
- Keyboard and game controller hotkeys are fully and easily configurable, and works from most applications and user interfaces 

## Usage
- Default keyboard hotkey trigger combination: ```"r+2+p"```
- Default controller hotkey trigger combination: ```"Mode/PS+DPAD_UP"```
<BR>([Suggestions here for better default choice of hotkey combinations are appreciated!](https://github.com/Vegz78/retro2png/issues/2))
- From the command line:
```
    Usage: raspi2png [dirname] [--pngname name] [--width <width>] [--height <height>] [--compression <level>] [--delay <delay>] [--display <number>] [--stdout] [--help]

    dirname - path of png file to create (default is /home/pi/Pictures)
    --pngname,-p - path and/or name of png file to create (default is retro2png.png)
    --height,-h - image height (default is screen height)
    --width,-w - image width (default is screen width)
    --compression,-c - PNG compression level (0 - 9)
    --delay,-d - delay in seconds (default 0)
    --display,-D - Raspberry Pi display number (default 0)
    --stdout,-s - write file to stdout
    --help,-H - print this usage information
```
<br>

## Simple Install to /usr/bin/

Run this command without sudo through terminal or CLI screen on most systems.

```curl -sL https://raw.githubusercontent.com/Vegz78/retro2png/master/installer.sh | bash -```

## Special Simple Install for Blast16&SNESES to /usr/bin/

Due to some missing libraries and certificates, tested on fresh Blast 16 v.1.0.18.
<br>ESC key to get to terminal from Blast16 to run this command without sudo.

```wget --no-check-certificate https://raw.githubusercontent.com/Vegz78/retro2png/master/installer_blast16.sh&&chmod +x ./installer_blast16.sh&&./installer_blast16.sh```
<br><br>

## Configuring the Gamepad and Keyboard Hotkeys
- To observe gamepad and keyboard button/key press codes, run(exit with CTRL+C):
```thd --dump /dev/input/event*```
- Edit(sudo) the file /etc/triggerhappy/triggers.d/retro2png.conf, example(tab-delimited):
<br>(key/btn combo, press/hold, command):
```
KEY_P+KEY_2+KEY_R	1	/usr/bin/retro2png
BTN_DPAD_UP+BTN_MODE	1	/usr/bin/retro2png
```
- , where:
  - key/btn combos are entered in conf file in opposite sequence of intended operating sequence, and up to 5 button combos per line
  - 0 = release, 1 = press and 2 = hold
  - the user running the process must have correct permissions for the command(default:pi/$USER, configured in file /lib/systemd/system/triggerhappy.service). Other commands may also be configured here
- After changes, update the service with: ```sudo systemctl daemon-reload```
- Restart service with: ```sudo systemctl restart triggerhappy.service```<br>

## Manual Building and Installing

You will need to install libpng-dev before you build the program. On Raspbian:

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

# Images
[![](docs/Screenshot_RetroPie.png)](https://github.com/Vegz78/retro2png/blob/master/docs/Screenshot_RetroPie.png?raw=true)
(Screenshot from RetroPie)

[![](docs/Screenshots_RetroPie.png)](https://github.com/Vegz78/retro2png/blob/master/docs/Screenshots_RetroPie.png?raw=true)
(In-game screenshot from RetroPie)

[![](docs/Screenshot_Recalbox.png)](https://github.com/Vegz78/retro2png/blob/master/docs/Screenshot_Recalbox.png?raw=true)
(Screenshot from Recalbox)

[![](docs/Screenshot_Raspberry_Pi_Desktop.jpeg)](https://github.com/Vegz78/retro2png/blob/master/docs/Screenshot_Raspberry_Pi_Desktop.jpeg?raw=true)
(Screenshot from Raspberry Pi Desktop)

[![](docs/Screenshot_Linux_console.png)](https://github.com/Vegz78/retro2png/blob/master/docs/Screenshot_Linux_console.png?raw=true)
(Screenshot from Raspberry Pi Linux console/CLI)
