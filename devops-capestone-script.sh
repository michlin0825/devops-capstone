## create jenkins user
sudo adduser jenkins
sudo passwd jenkins


## set up Jenkins build server
# update patches
sudo yum update -y

# Install and enable the EPEL rpm package on RHEL 7 and Amazon Linux 2
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm


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
sudo yum install docker-ce docker-ce-cli containerd.io
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
# sudo yum install tidy -y
# sudo yum install pylint -y
# sudo pip install pylint
# sudo pip install flask 
# sudo systemctl restart jenkins


## setup jenkins server on the console
## install blue ocean plugin and github integration
## configure docker hub and aws pipeline credential 







## set up EKS cluster
# install awscli and set aws credentials
sudo yum -y install python-pip
sudo pip install awscli -y
aws configure

# install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

# install kubectl 
curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
kubectl version --short --client

# create eks cluster
eksctl create cluster \
--name devops-capstone \
--version 1.14 \
--nodegroup-name standard-workers \
--node-type t3.medium \
--nodes 3 \
--nodes-min 1 \
--nodes-max 4 \
--node-ami auto

# verify eks installation
kubectl get svc

# deploy to eks cluster
kubectl apply -f Deployment/webapp-deploy.yml


## trouble shooting resources
# install aws-iam-authenticator
curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
aws-iam-authenticator help

# upate EKS config
aws eks update-kubeconfig --region us-east-1 --name devops-capstone 

# verify eks installation
kubectl get svc

# deploy to eks cluster
kubectl apply -f Deployment/webapp-deploy.yml





## other references
# install git
sudo yum install git -y

# clone repo
git clone https://github.com/michlin0825/devops-capstone.git
cd devops-capstone/

# install python3
sudo yum -y install yum-utils
sudo yum -y groupinstall development
sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm
sudo yum -y install python36u
python3.6 -V
sudo yum -y install python36u-pip
pip3.6 install pandas
sudo yum -y install python36u-devel
