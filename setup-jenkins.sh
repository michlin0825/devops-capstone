## create jenkins user
sudo adduser jenkins
sudo passwd jenkins
sudo usermod -aG wheel jenkins

# add jenkins to sudoers
sudo visudo
'jenkins ALL=(ALL) NOPASSWD: ALL'
su - jenkins
exit


# Install and enable the EPEL rpm package on RHEL 7 and Amazon Linux 2
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# update patches
sudo yum update -y

# turn off priorities
sudo nano /etc/yum/pluginconf.d/priorities.conf
'enaled = 0'

# install jenkins and java dependency
sudo yum install java-1.8.0-openjdk.x86_64 -y
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
sudo grep -A 5 password /var/log/jenkins/jenkins.log

# install docker
# sudo yum install -y yum-utils device-mapper-persistent-data lvm2
# sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# sudo yum install docker-ce docker-ce-cli containerd.io --skip-broken
sudo yum install docker -y
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
# sudo docker run hello-world

#REDHAT specific
sudo yum remove docker docker-common docker-selinux docker-engine-selinux docker-engine docker-ce -y
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce --nobest -y
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
# sudo docker run hello-world

# add jenkins user to docker group
sudo usermod -aG docker jenkins

# install dependencies for jenkins user
su - jenkins

sudo yum install nodejs -y # for installation of npm
sudo npm install dockerlint -g
sudo yum install python3-pip -y
sudo pip3 install flask
sudo pip3 install pylint
export PATH=/usr/local/bin/:$PATH

# set up aws credentials for jenkins user
sudo yum install python3-pip -y
sudo pip3 install awscli --upgrade
aws configure

# restart jenkins to reflect latest pathces 
sudo systemctl stop jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

## setup jenkins server on the console
## install blue ocean plugin and github integration
## configure docker hub and aws credential 
## configure environment variables in Jenins system/global properties

# install git
sudo yum install git -y

# clone repo
git clone https://github.com/michlin0825/devops-capstone.git
cd devops-capstone/

## other fixes
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_COLLATE=C
export LC_CTYPE=en_US.UTF-8
