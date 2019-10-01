pipeline {
    environment {
    registry = "michlin0825/devops-capstone"
    registryCredential = 'docker_hub'
    }
    
    agent any
    stages {
        
        stage ('Linting HTML and Python files') {
            steps {
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

        stage ('Deploying to AWS EKS') {
            steps {
                withAWS(credentials: 'AWS', region: 'us-east-1') {
                    script {
                       sh 'echo "Hello World"'
                       sh 'curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl'
                       sh 'chmod +x ./kubectl'
                       sh 'mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH'
                       sh 'echo \'export PATH=$HOME/bin:$PATH\' >> ~/.bashrc'
                       sh 'kubectl version --short --client'
                       sh 'kubectl get svc' 
                       sh 'kubectl apply -f Deployment/webapp-deploy.yml'
                    }
                }
            }
        }    
    }
}