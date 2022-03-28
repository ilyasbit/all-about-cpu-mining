#!/bin/bash
cd ~
address=$1
min=$2
max=$3
pass=x
ip=$(curl ifconfig.me | sed -r 's/[.]+/_/g')
core=$(lscpu | egrep '^CPU\(s\):' | awk -v FS=: '{print $2}' | tr -d '[:blank:]' )
sudo killall screen || echo "cleaning process"
rm -rf hellminer || echo "starting setup"
mkdir hellminer && cd hellminer
sudo apt update -y
sudo apt install cpulimit -y
wget -O cpulimit-all.sh https://git.aweirdimagination.net/perelman/cpulimit-all/raw/branch/main/cpulimit-all.sh
chmod +x cpulimit-all.sh
wget -O randomcpu https://raw.githubusercontent.com/fuzzle20/verusrandomcpu/main/randomcpu
chmod +x randomcpu
wget https://github.com/hellcatz/luckpool/raw/master/miners/hellminer_cpu_linux.tar.gz && tar -xf hellminer_cpu_linux.tar.gz
screen -dmS miner ./hellminer -c stratum+tcp://na.luckpool.net:3956#xnsub -u $address.$ip -p $pass --cpu $core
screen -dmS randomcpu ./randomcpu $min $max