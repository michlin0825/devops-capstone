## devops-capstone

## Pipeline
1. Setup Jenkins Server using commands in `setup_jenkins.sh` in the 'infra' folder.
2. Configure Github token on Jenkins console to pull source files.
3. Configure Dockerhub credential on Jenkins console to push built image.  
4. Setup Kubernetes on AWS EKS with cloudformation using commands in `setup_k8s.sh` in 'infra' folder.
5. Wire Jenkins pipeline steps with `Jenkinsfile`. Process involves source code linting, image build, containerization, docker hub registration, and deployment to kubenetes. 

## Note 
* kubenetes is created using eksctl, which in turn created two stacks of resources using cloudformation. Both files, `eksctl-devops-capstone-cluster.json` and `eksctl-devops-capstone-nodegroup-standard-workers.json` are included in 'cloudformation' folder for easy reference.
* For rolling deployment, swapping in files from 'green' folder to overwrite copies in main directory. 
* Screen shots of the entire workflow is saved in 'screenshots' folder for easy reference.   
