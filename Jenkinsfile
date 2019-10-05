pipeline {
    environment {
    registry = "michlin0825/devops-capstone"
    registryCredential = 'docker_hub'
    }
    
    agent any
    stages {
        
        stage ('Linting Project Files') {
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

        stage('Building Docker Image') {
            steps {
                script {
                    sh 'docker build --tag=michlin0825/devops-capstone .'
                }
            }
        }

        stage('Publishing Docker Image') {
            steps {
                script {
                    withDockerRegistry([ credentialsId: "docker_hub", url: "" ]) {
                    sh 'docker push michlin0825/devops-capstone:$BUILD_NUMBER'
                    }
                }
            }
        }

        stage('Cleaning Image Artificat') {
            steps{
                sh "docker rmi $registry:$BUILD_NUMBER"


        stage ('Deploying to EKS') {
            steps {
                withAWS(credentials: 'AWS', region: 'us-east-1') {
                    sh 'curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl'
		    sh 'pwd'
		    sh 'ls'
                    sh 'chmod +x ./kubectl'
                    sh './kubectl version --short --client'
                    sh './kubectl apply -f ./Deployment/webapp-deploy.yml'
                    sh 'sleep 5'
                    sh 'kubectl get svc webapp-service'
                    sh 'cat kubernetes/helloworld-deployment.yaml | sed \'s/\$BUILD_NUMBER\'"/$BUILD_NUMBER/g" | kubectl apply -f -'
                    sh 'kubectl get pods'
                    sh 'sleep 15'
                    sh 'kubectl get pods'
                    }
                }
            }
        }    
    }
}
