# weiss-exercise
04DEC2023 
14:20 - 


# Create GitHub Repo
https://github.com/dvorkinguy/weiss-exercise.git


# Create K8s cluster
I have created in AWS using Terraform
![weiss-eks-cluster](images/weiss-eks-cluster.png)

# Download and Install Helm 
https://github.com/helm/helm/releases/tag/v3.13.2
Installed on Linux amd64
Download: wget https://get.helm.sh/helm-v3.13.2-linux-amd64.tar.gz
Extract: tar -xf helm-v3.13.2-linux-amd64.tar.gz
sudo mv helm /bin/

# Create Helm deployment
weiss-chart folder created
templates folder created
maximum variables usage in the deploy and svc yamls
# weiss-deploy
