pipeline {
    environment {
    registry = "michlin0825/devops-capstone"
    registryCredential = 'docker_hub'
    }
    
    agent any
    stages {
        
        stage ('Linting Project Files') {
            steps {
                sh 'pip3 install flask pylint'
                sh '/usr/local/bin/pylint app.py'
                sh 'tidy -q -e *.html'         
            }
        }

        stage ('Cloning Git') {
            steps {
                git 'https://github.com/michlin0825/devops-capstone.git'
            }
        }

        stage('Building Docker Image') {
            steps {
                script {
                    sh 'docker build --tag=michlin0825/devops-capstone .'
                }
            }
        }

        stage('Uploading Docker Image') {
            steps {
                script {
                    withDockerRegistry([ credentialsId: "docker_hub", url: "" ]) {
                    sh 'docker push michlin0825/devops-capstone'
                    }
                }
            }
        }

        stage ('Deploying to EKS') {
            steps {
                withAWS(credentials: 'AWS', region: 'us-east-1') {
                    script {
                    sh 'curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp'
                    sh '/tmp/eksctl version'
                    sh '/tmp/eksctl create cluster --name devops-capstone --version 1.14 --nodegroup-name standard-workers --node-type t3.medium --nodes 3 --nodes-min 1 --nodes-max 4 --node-ami auto'
                    sh 'curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl'
                    sh 'chmod +x ./kubectl'
                    sh './kubectl version --short --client'
                    sh './kubectl get svc' 
                    sh './kubectl apply -f Deployment/webapp-deploy.yml'
                    }
                }
            }
        }    
    }
}