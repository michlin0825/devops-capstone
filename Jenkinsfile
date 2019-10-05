pipeline {
    environment {
    registry = "michlin0825/devops-capstone"
    registryCredential = 'docker_hub'
    }
    
    agent any
    stages {
        
        stage ('Linting Files') {
            steps {
                sh 'tidy -q -e *.html'
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
                sh "docker rmi $registry"
            }
        }

        stage ('Deploying to EKS') {
            steps {
                withAWS(credentials: 'AWS', region: 'us-east-1') {
                    sh 'curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl'
                    sh 'chmod +x ./kubectl'
                    sh './kubectl version --short --client'
                    sh 'curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator'
                    sh 'chmod +x ./aws-iam-authenticator'
                    sh 'sudo mkdir -p ~/home/jenkins/bin && sudo cp ./aws-iam-authenticator ~/home/jenkins/bin/aws-iam-authenticator && export PATH=~/home/jenkins/bin:$PATH'
                    sh 'aws eks update-kubeconfig --region us-east-1 --name devops-capstone' 
                    sh 'kubectl apply -f webapp-deploy.yml'
                    sh 'sleep 5'
                    sh './kubectl get svc webapp-service'
                    sh 'sleep 5'
                    sh './kubectl get pods'
                }
            }
        } 
    }
}
