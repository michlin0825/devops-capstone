## devops-capstone

1. Setup Jenkins Server using commands in `setup_jenkins.sh` in the 'infra' folder.
2. Configure Github token on Jenkins console to pull source files.
3. Configure Dockerhub credential on Jenkins console to push built image.  
4. Setup Kubernetes on AWS EKS with cloudformation using commands in `setup_k8s.sh` in 'infra' folder.
5. Wire Jenkins pipeline steps with `Jenkinsfile`.
6. Build docker image with `Dockerfile`.
7. Publish webapp to Kubernetes with `webapp-deploy.yml`.
8. Check out deployed webapp on browser.
9. app.py is not used in deployment. It is included to test drive pylint as a pre-built exercise. 
10. kubenetes is created using EKSCTL, which in turn created two stacks of resources using cloudformation. Both files, `eksctl-devops-capstone-cluster.json` and `eksctl-devops-capstone-nodegroup-standard-workers.json` are included in 'cloudformation' forder for easy reference.
11. To test rolling deployment, swap in files from 'green' folder to overwrite counterpart copies in main directory. 
12. Screen shots of the entire workflow is saved in 'screenshots' folder for easy reference.   
