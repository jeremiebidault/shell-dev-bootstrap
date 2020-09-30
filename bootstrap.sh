#!/bin/bash

# nfs
mkdir /data
echo "10.0.0.10:/volume1/nfs/dev /data nfs defaults,auto,_netdev 0 2" >> /etc/fstab
mount -a

# nodejs
wget https://nodejs.org/dist/v13.9.0/node-v13.9.0-linux-x64.tar.gz
mkdir -p /usr/local/lib/nodejs
tar -xvf node-v13.9.0-linux-x64.tar.gz -C /usr/local/lib/nodejs

echo "export PATH=/usr/local/lib/nodejs/node-v13.9.0-linux-x64/bin/:$PATH" >> ~/.bashrc
. ~/.bashrc

node -v
npm -v

rm -rf node-v13.9.0-linux-x64.tar.gz

# yarn
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
yum -y install yarn

yarn -v

# angular
yarn global add @angular/cli --prefix /usr
ng config --global cli.packageManager yarn

ng --version

# golang
wget https://golang.org/dl/go1.15.1.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.15.1.linux-amd64.tar.gz

echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc
. ~/.bashrc

go version

rm -rf go1.15.1.linux-amd64.tar.gz

# openjdk
wget https://download.java.net/java/GA/jdk14.0.2/205943a0976c4ed48cb16f1043c5c647/12/GPL/openjdk-14.0.2_linux-x64_bin.tar.gz
mkdir -p /usr/local/lib/openjdk
tar -xvf openjdk-14*_bin.tar.gz -C /usr/local/lib/openjdk

cat <<EOF >> ~/.bashrc
export JAVA_HOME=/usr/local/lib/openjdk/jdk-14.0.2
export PATH=$PATH:/usr/local/lib/openjdk/jdk-14.0.2/bin
EOF
. ~/.bashrc

rm -rf openjdk-14.0.2_linux-x64_bin.tar.gz

# maven
wget https://mirroir.wptheme.fr/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
mkdir -p /usr/local/lib/maven
tar -xvf apache-maven-3.6.3-bin.tar.gz -C /usr/local/lib/maven

echo "export PATH=$PATH:/usr/local/lib/maven/apache-maven-3.6.3/bin" >> ~/.bashrc
. ~/.bashrc

mvn -version

rm -rf apache-maven-3.6.3-bin.tar.gz

# gradle
dnf -y install zip unzip
wget https://services.gradle.org/distributions/gradle-6.6.1-bin.zip
unzip -d /usr/local/lib/gradle gradle-6.6.1-bin.zip

cat <<EOF >> ~/.bashrc
export GRADLE_HOME=/usr/local/lib/gradle/gradle-6.6.1
export PATH=$PATH:/usr/local/lib/gradle/gradle-6.6.1/bin
EOF

gradle -v

rm -rf gradle-6.6.1-bin.zip

# ansible
dnf makecache
dnf -y install epel-release
dnf makecache
dnf -y install ansible

ansible --version
