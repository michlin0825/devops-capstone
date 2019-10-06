## devops-capstone

1. Setup Jenkins Server on EC2 using commands in `setup_jenkins.sh`
2. Configure Git Hub token on Jenkins console to pull source files.
3. Configure docker hub credential on Jenkins console to push built image.  
4. Setup Kubernetes on AWS EKS (and underlying cloudformation) using commands in `setup_k8s.sh`
5. Wire Jenkins pipeline with `Jenkinsfile` 
* source files are stored in github
* source files checked out are verified with pylint and dockerlint 
* source files are built into image file with help of docker container 
* built image is uploaded to docker hub for registry 
* docker artifacts are removed
* built image on docker hub is pulled into kubernetes for deployment
