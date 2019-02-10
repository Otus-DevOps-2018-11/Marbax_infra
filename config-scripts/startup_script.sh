#!/bin/bash
sudo su -
apt-get update
apt-get install -y ruby-full ruby-bundler build-essential
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list
apt-get update
apt-get install -y mongodb-org
systemctl start mongod
systemctl enable mongod
cd ~ 
git clone -b monolith https://github.com/express42/reddit.git
cd reddit/
bundle install
puma -d
