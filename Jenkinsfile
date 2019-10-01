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
                sh 'pylint --disable=R,C,W1203 app.py'
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
                       sh 'aws iam get-user'
                       sh 'curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator'
                       sh 'chmod +x ./aws-iam-authenticator'
                       sh 'mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH'
                       sh 'echo "export PATH=$HOME/bin:$PATH" >> ~/.bashrc'
                       sh 'aws sts get-caller-identity'
                       sh 'aws eks --region us-east-1 update-kubeconfig --name pipeline'
                       sh 'kubectl get svc' 
                       sh 'kubectl apply -f Deployment/webapp-deploy.yml'
                    }
                }
            }
        }    
    }
}