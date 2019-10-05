## create jenkins user
sudo adduser jenkins
sudo passwd jenkins
sudo usermod -aG wheel jenkins
sudo visudo
'jenkins ALL = NOPASSWD: /usr/local/lib'
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

# add jenkins user to docker group
sudo usermod -aG docker jenkins
# add jenkins to sudoers
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

# install dependencies to faciliate jenkins build process
sudo yum install tidy -y
sudo yum install python3-pip -y
sudo yum install nodejs -y # for installation of npm
sudo npm install dockerlint -g
sudo pip3 install flask
sudo pip3 install pylint

## setup jenkins server on the console
## install blue ocean plugin and github integration
## configure docker hub and aws pipeline credential 

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
