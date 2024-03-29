#!/usr/bin/env bash
# @author: O5t3
# A simple script to auto install necessary tools that i use from time to time in offsec, defense & ctf scenarios


function toolbelt() {
    sudo apt install vim nano tmux openvpn terminator freerdp2-x11 sliver powershell-empire sublist3r ffuf wfuzz gobuster starkiller evil-winrm mlocate dnsutils openssh-server openssh-client dirbuster enum4linux kali-desktop-i3 feroxbuster dnswalk nuclei wpscan git legion armitage john hashcat python3-scapy cewl dnsenum dirsearch hashid whatweb recon-ng dnsmap sherlock netcat-traditional powershell beef-xss set steghide netdiscover stegcracker medusa theharvester fcrackzip sslscan whois hash-identifier python3-impacket ollydbg libimage-exiftool-perl jd-gui exploitdb  exploitdb-papers exploitdb-bin-sploits bloodhound neo4j neofetch seclists hakrawler libgconf-2-4 python3-tk imagemagick xdotool parallel bc libcurl4-openssl-dev amass python-pip sshuttle rlwrap p7zip p7zip-full chisel golang -y && sudo apt autoremove && sudo apt update && sudo apt upgrade -y 
}

function pipinstalls() {
    python3 -m pip install termcolor cprint pycryptodomex requests install minidump minikerberos aiowinreg msldap winacl pypykatz impacket git-dumper oletools droopescan stegoveritas stego-lsb Pillow &&
/usr/bin/python3 -m pip install --upgrade pip && sudo apt install python3-pip && pip3 install updog
}

function goinstall() {
    cd /tmp && wget https://go.dev/dl/go1.18.4.linux-amd64.tar.gz && sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.18.4.linux-amd64.tar.gz && export PATH=$PATH:/usr/local/go/bin
}

function nodejsinstall() {
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo  bash - && sudo apt-get install gcc g++ make nodejs -y 
}

function yarninstall() {
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
     echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
     sudo apt-get update && sudo apt-get install yarn
}

function dotnetinstall() {
    cd ~/ && wget https://download.visualstudio.microsoft.com/download/pr/9de47381-6c20-4f80-a907-261d35f6157d/bab9b2f375d647e22a14251529328868/dotnet-sdk-3.1.421-linux-x64.tar.gz && mkdir -p $HOME/dotnet && sudo tar zxf dotnet-sdk-3.1.421-linux-x64.tar.gz -C $HOME/dotnet && export DOTNET_ROOT=$HOME/dotnet && export PATH=$PATH:$HOME/dotnet
}

function directories() {
    cd ~/Downloads && mkdir -p Tools/{Steg,Offsec,Web,Forensics,AppImages,Misc,LinuxEnum,OSINT}
}

function vault() {
	cd ~/Documents && mkdir -p Vault/{CTF-Time,HTB,THM,Offsec,CheatSheet,CyberTalents,CyberDefenders,Assets,LetDefend,AD,ToDO}
}


function appimages() {
    cd ~/Downloads/Tools/Steg && wget https://github.com/audacity/audacity/releases/download/Audacity-3.1.3/audacity-linux-3.1.3-x86_64.AppImage && mv audacity-linux-3.1.3-x86_64.AppImage audacity && chmod +x audacity && wget https://code.soundsoftware.ac.uk/attachments/download/2825/SonicVisualiser-4.5-x86_64.AppImage && mv SonicVisualiser-4.5-x86_64.AppImage sonicvisualiser && chmod +x sonicvisualiser && sudo ln -s ~/Downloads/Tools/Steg/sonicvisualiser /usr/bin && sudo ln -s ~/Downloads/Tools/Steg/audacity /usr/bin && cd ~/Downloads/Tools/AppImages && wget https://github.com/obsidianmd/obsidian-releases/releases/download/v0.15.8/Obsidian-0.15.8.AppImage && mv  Obsidian-0.15.8.AppImage obsidian && chmod +x obsidian && sudo ln -s /home/kali/Downloads/Tools/AppImages/obsidian /usr/bin
}


function deb-installs() {
    cd /tmp && wget https://download.sublimetext.com/sublime-text_build-3211_amd64.deb  && wget https://github.com/flameshot-org/flameshot/releases/download/v12.1.0/flameshot-12.1.0-1.debian-10.amd64.deb && wget https://github.com/syvaidya/openstego/releases/download/openstego-0.8.4/openstego_0.8.4-1_all.deb && wget https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb && wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb && sudo dpkg -i *.deb && sudo rm -r *.deb 
}

function offsec() {
    cd ~/Downloads/Tools/Offsec && git clone https://github.com/S3cur3Th1sSh1t/OffensiveVBA.git && git clone https://github.com/dirkjanm/krbrelayx.git && git clone https://github.com/d0nkeys/redteam.git && git clone https://github.com/Flangvik/SharpCollection.git && git clone https://github.com/r3motecontrol/Ghostpack-CompiledBinaries.git && git clone https://github.com/PwnDexter/SharpEDRChecker.git && git clone https://github.com/curi0usJack/luckystrike.git && git clone https://github.com/JoelGMSec/AutoRDPwn.git && git clone --recurse-submodules https://github.com/cobbr/Covenant && git clone https://github.com/internetwache/GitTools.git && git clone https://github.com/kmahyyg/mremoteng-decrypt.git && git clone https://github.com/haseebT/mRemoteNG-Decrypt.git && git clone https://github.com/PowerShellMafia/PowerSploit.git && git clone https://github.com/andrew-d/static-binaries.git && git clone https://github.com/matterpreter/OffensiveCSharp.git && git clone https://github.com/ropnop/go-windapsearch.git 
}

function privesc() {
    cd ~/Downloads/Tools/LinuxEnum && wget https://github.com/carlospolop/PEASS-ng/releases/download/20220724/linpeas.sh && wget https://github.com/carlospolop/PEASS-ng/releases/download/20220724/winPEAS.bat && wget https://github.com/carlospolop/PEASS-ng/releases/download/20220724/winPEASx64.exe && wget https://github.com/carlospolop/PEASS-ng/releases/download/20220724/winPEASx64_ofs.exe && wget "https://github.com/diego-treitos/linux-smart-enumeration/releases/latest/download/lse.sh" -O lse.sh;chmod 700 lse.sh && wget "https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh" -O LinEnum.sh;chmod 700 LinEnum.sh && wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32 && wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64 && wget "https://raw.githubusercontent.com/linted/linuxprivchecker/master/privcheckerserver.py" -O privcheckerserver.py;chmod 700 privcheckerserver.py && wget "https://raw.githubusercontent.com/linted/linuxprivchecker/master/linuxprivchecker_async.py" -O linuxprivchecker_async.py;chmod 700 linuxprivchecker_async.py && wget "https://raw.githubusercontent.com/linted/linuxprivchecker/master/linuxprivchecker.sh" -O linuxprivchecker.sh;chmod 700 linuxprivchecker.sh && wget "https://raw.githubusercontent.com/linted/linuxprivchecker/master/linuxprivchecker.py" -O linuxprivchecker.py;chmod 700 linuxprivchecker.py && wget "https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh" -O les.sh;chmod 700 les.sh
}

function web() {
    cd ~/Downloads/Tools/Web && git clone https://github.com/inc0d3/moodlescan.git && git clone https://github.com/rezasp/joomscan.git && git clone https://github.com/tomnomnom/httprobe.git
}

function forensics() {
    cd ~/Downloads/Tools/Forensics && git clone https://github.com/volatilityfoundation/volatility.git && git clone https://github.com/sans-blue-team/DeepBlueCLI.git && git clone git clone https://github.com/sbousseaden/EVTX-ATTACK-SAMPLES.git
}

function osint() {
    cd ~/Downloads/Tools/OSINT && git clone https://github.com/m4ll0k/Infoga.git && cd Infoga && wget https://bootstrap.pypa.io/pip/2.7/get-pip.py && python get-pip.py && pip2 install -r requirements.txt && python setup.py install
}

function gotools() {
    go install github.com/lc/gau/v2/cmd/gau@latest && go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && go install github.com/tomnomnom/assetfinder@latest && go install github.com/Ullaakut/cameradar/v5/cmd/cameradar@latest 
}

function wallpaper() {
    cd ~/Pictures && git clone https://github.com/a2n-s/mut-ex-wallpapers.git 
}

function omz() {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function run_all() {
    toolbelt ; pipinstalls ; goinstall ; nodejsinstall ; yarninstall ; dotnetinstall ; directories ; vault ; appimages ; deb-installs ; offsec ; privesc ; web ; forensics ; osint ; gotools ; wallpaper ; omz
}
