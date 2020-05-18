# 1. Install dependencies
sudo apt update
sudo apt install -y libpng-dev git-core triggerhappy
sudo apt --reinstall install -y libc6 libc6-dev

# 2. Download and extract retro2png
cd ~
wget --no-check-certificate https://github.com/Vegz78/retro2png/archive/master.zip
unzip ./master.zip
mv ./retro2png-master ./retro2png
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
rm -fr master.zip
retro2png -H
mkdir ~/Pictures
