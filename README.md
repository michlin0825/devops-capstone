## devops-capstone

1. Setup Jenkins Server on EC2 using commands in `setup_jenkins.sh`.
2. Configure Github token on Jenkins console to pull source files.
3. Configure Dockerhub credential on Jenkins console to push built image.  
4. Setup Kubernetes on AWS EKS with cloudformation using commands in `setup_k8s.sh`.
5. Wire Jenkins pipeline steps with `Jenkinsfile`.
6. Build docker image with `Dockerfile`.
7. Publish webapp to Kubernetes with `webapp-deploy.yml`.
8. Check out deployed webapp on browser.
9. app.py is not used in deployment. It is included to use pylint as pre-built exercise. 
10. kubenetes is created using EKSCTL cli, which in turn created two stacks of resources using cloudformation. Both files, `eksctl-devops-capstone-cluster.json` and `eksctl-devops-capstone-nodegroup-standard-workers.json` are included in 'cloudformation' forder as reference.
11. To test rolling deployment, swap in files from 'green' folder. 
12. screen shots of the workflow is saved in 'screenshots' folder for reference.   
