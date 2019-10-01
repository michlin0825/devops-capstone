pipeline {
    environment {
    registry = "michlin0825/devops-capstone"
    registryCredential = 'docker_hub'
    }
    
    agent any
    stages {
        
        stage ('Linting HTML and Python files') {
            steps {
                sh 'sudo tidy -q -e *.html'
                sh 'sudo pylint --disable=R,C,W1203 app.py'
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
                       sh 'kubectl get svc' 
                       sh 'kubectl apply -f Deployment/webapp-deploy.yml'
                    }
                }
            }
        }    
    }
}