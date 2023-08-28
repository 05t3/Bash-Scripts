#!/bin/bash

# Update package list and install dependencies
sudo apt update && sudo apt-get install automake libtool make gcc pkg-config unzip flex bison libssl-dev libjansson-dev libmagic-dev -y

# Download YARA from GitHub and install
wget https://github.com/VirusTotal/yara/archive/refs/tags/v4.3.2.zip
unzip v4.3.2.zip
cd yara-4.3.2
bash bootstrap.sh
./configure --enable-cuckoo --enable-magic --enable-dotnet
make
sudo make install
make check

echo "YARA installed successfully!"

# Add library path to ~/.bashrc and source it
echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/lib" >> ~/.bashrc
source ~/.bashrc

# Clean up
cd ..
rm -rf yara-4.3.2
rm v4.3.2.zip
