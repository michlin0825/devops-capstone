pipeline {
    environment {
    registry = "michlin0825/devops-capstone"
    registryCredential = 'docker_hub'
    }
    
    agent any
    stages {
        
        stage ('Linting Files') {
            steps {
                sh '#tidy -q -e *.html'
                sh 'whoami'
                sh 'pwd'
                sh 'ls'
                sh '/usr/local/bin/pylint app.py --disable=missing-docstring'
		        sh 'dockerlint Dockerfile'         
            }
        }

        stage ('Cloning Git') {
            steps {
                git 'https://github.com/michlin0825/devops-capstone.git'
            }
        }

        stage('Building Image') {
            steps {
                script {
                    sh 'docker build --tag=michlin0825/devops-capstone .'
                }
            }
        }

        stage('Publishing Image') {
            steps {
                script {
                    withDockerRegistry([ credentialsId: "docker_hub", url: "" ]) {
                    sh 'docker push michlin0825/devops-capstone'
                    }
                }
            }
        }

        stage('Cleaning Artificat') {
            steps{
                sh 'docker rmi $registry'
            }
        }

        stage ('Deploying to EKS') {
            steps {
                withAWS(credentials: 'AWS', region: 'us-east-1') {
                    sh 'pwd'
                    sh 'ls'
                    sh 'curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl'
                    sh 'chmod +x ./kubectl'
                    sh 'mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH'
                    sh './kubectl version --short --client'
                    sh 'curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator'
                    sh 'chmod +x ./aws-iam-authenticator'
                    sh 'mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH'
                    sh 'pip3 install awscli --upgrade'
                    sh '/usr/local/lib/python3.6/site-packages/aws s3 ls'
                    sh '/usr/local/bin/aws eks update-kubeconfig --region us-east-1 --name devops-capstone'
                    sh '/usr/local/bin/aws sts get-caller-identity'
                    sh 'ln -s /usr/local/bin/aws /var/lib/jenkins/workspace/devops-capstone_master/aws'
                    sh 'pwd'
                    sh 'ls'
                    sh './kubectl get services'
                    sh './kubectl get pods'
                    sh './kubectl apply -f webapp-deploy.yml'
                    sh 'sleep 10'
                    sh './kubectl get services webapp-service'
                    sh 'sleep 10'
                    sh './kubectl get pods'
                }
            }
        } 
    }
}
