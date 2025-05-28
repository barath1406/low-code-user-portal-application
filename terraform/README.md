# User Portal Infrastructure

This folder hosts the  IaC to host the User portal in AWS. 

### Folder structure
* `modules` - Contains base modules for creating AWS resources
* `global` - This folder contains globl AWS resources (i.e. iam or route53) 
* `us-east-1` - This folder contains base infrastructure resources that are deployed on the AWS us-east-1 region 




### How to run
To initialize and run terraform, please run: 
```bash
 cd ./global
 terraform init --backend-config backend/dev.tfvars --reconfigure
 terraform plan --var-file vars/dev.tfvars
```
