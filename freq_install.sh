#!bin/bash

echo 'install ta-lib'
wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar xvzf ta-lib-0.4.0-src.tar.gz
cd ta-lib
sed -i.bak "s|0.00000001|0.000000000000000001 |g" src/ta_func/ta_utility.h
./configure --prefix=/usr/local
make -j
sudo make install
# On debian based systems (debian, ubuntu, ...) - updating ldconfig might be necessary.
sudo ldconfig  
cd ..
rm -rf ./ta-lib*

# update repository
sudo apt-get update

# install packages
sudo apt install -y git curl python-is-python3 pip python3-pip python3-venv python3-dev python3-pandas

# install freqtrade
# Download `develop` branch of freqtrade repository
echo 'Enter dirname or enter to use default'
read dir
defaultDir='freqtrade'
onDir=${dir:-$defaultDir}
git clone https://github.com/freqtrade/freqtrade.git $onDir

# Enter downloaded directory
cd $onDir

# your choice (1): novice user
git checkout stable

# --install, Install freqtrade from scratch
./setup.sh -i

echo '# activate env'
echo 'source ./.env/bin/activate'
echo '# Step 1 - Initialize user folder: '
echo 'freqtrade create-userdir --userdir user_data'
echo '# Step 2 - Create a new configuration file: '
echo 'freqtrade new-config --config config.json'
echo '# Sample strategies: https://github.com/freqtrade/freqtrade-strategies'
echo '# install freqtrade UI: '
echo 'freqtrade install-ui'
echo '# start the bot: '
echo 'freqtrade trade --config config.json --strategy SampleStrategy'
