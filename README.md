![jenkins](https://github.com/michlin0825/devops-capstone/blob/master/capstone_top.jpg)


## Udacity DevOps Engineer Capstone

### Summary
The capstone uses infastructure as code to stand up Jenkins server and EKS cluster on AWS. Jenkins' pipeline enables continuous integration and continuous deployment, while k8s cluster hosts microservice for the sample app. 


### Workflow
1. Setup Jenkins Server using commands in `setup_jenkins.sh` in 'infra' folder.
2. Configure Github token on Jenkins console to pull source files.
3. Configure Dockerhub credential on Jenkins console to push built image.  
4. Setup k8s cluster on AWS EKS with cloudformation using commands in `setup_k8s.sh` in 'infra' folder.
5. Wire Jenkins pipeline with `Jenkinsfile`. Jobs include source code linting, image building, registration to docker hub, and deployment to k8s. 


### Note 
* k8s cluster is created using eksctl, which in turn creates two stacks of resources using cloudformation. Both files, `eksctl-devops-capstone-cluster.json` and `eksctl-devops-capstone-nodegroup-standard-workers.json` are included in 'cloudformation' folder for easy reference.
* For rolling deployment, swapping in files from 'green' folder to overwrite copies in main directory. 
* Screen shots of the entire workflow is saved in 'screenshots' folder for easy reference.   
