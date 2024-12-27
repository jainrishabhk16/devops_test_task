# devops_test_task
![Oozou](https://cdn.oozou.com/assets/website/favicon-32x32-31e7864857aa3fc3b35d0c34bfea6b8e0cdeb22f8f6317701c0f7f0df564543f.png)


## Introduction

This is a technical test for the role of **DevOps Engineer**.

## Objectives

This test helps us to understand
- how do you approach infrastructure design
- how do you manage microservices communication
- how do you consider security implications

## Project Setup

Project root has [`index.js`](/index.js) file. It simulates a simple app that runs infinitely & sends metrics to a [`statsd`](https://github.com/statsd/statsd) server.

## Exercices

  1. Add a `Dockerfile` to containerize the app, with support for multiple environments (DEV, UAT & Production)
  2. Design the cloud infrastructure diagram (prefer AWS) with all the resources that are required for the application(Node app, `statsd` & the backend. Applicants can use any backends for `statsd` eg: `Graphite`). Use ECS or EKS as application platform.
  3. Utilize Terraform to establish infrastructure that adheres to industry-standard security and high availability (HA) practices.
  4. (Optional) Deploy on the cloud computing platforms

## Submitting Your Code

Email us your Github repo and grant he access to `lycbrian` We expect meaningful git commits, ideally one commit per exercise with commit messages clearly communicating the intent.

If you deploy it to any cloud platforms, please send us instructions & relevant IAM user credentials.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Tasks performed

![image](https://github.com/jainrishabhk16/devops_test_task/blob/main/secure-architecture-complete-flows.svg)


### Added Dockerfile
- Creating a `Dockerfile` will allow us to build the docker image for the application. We will be using the .env file to pass on the environment variables to build images for different environments.

### Terraform
- We are creating terraform modules to deploy services on AWS. We will be creating modules for deploying our application on the AWS EKS cluster. 
- We are adding modules for EKS, VPC, WAF, Security Group, Kubernetes and Load balancing. Given below is the folder structure for the project.
- We are using modules for [EKS](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest) and [VPC](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) which are provided by terraform. 


```bash.
├── Dockerfile
├── index.js
├── package.json
├── package-lock.json
├── README.md
└── terraform
    ├── environments
    │   ├── dev
    │   │   ├── backend.tf
    │   │   ├── locals.tf
    │   │   ├── main.tf
    │   │   ├── provider.tf
    │   │   ├── terraform.tfvars
    │   │   └── variables.tf
    │   ├── prod
    │   │   ├── backend.tf
    │   │   ├── locals.tf
    │   │   ├── main.tf
    │   │   ├── provider.tf
    │   │   ├── terraform.tfvars
    │   │   └── variables.tf
    │   └── uat
    │       ├── backend.tf
    │   │   ├── locals.tf
    │   │   ├── main.tf
    │   │   ├── provider.tf
    │   │   ├── terraform.tfvars
    │   │   └── variables.tf
    └── modules
        ├── eks
        │   ├── main.tf
        │   ├── outputs.tf
        │   └── variables.tf
        ├── kubernetes
        │   ├── main.tf
        │   ├── outputs.tf
        │   └── variables.tf
        ├── load_balancer
        │   ├── main.tf
        │   ├── outputs.tf
        │   └── variables.tf
        ├── security_groups
        │   ├── main.tf
        │   ├── outputs.tf
        │   └── variables.tf
        ├── vpc
        │   ├── main.tf
        │   ├── outputs.tf
        │   └── variables.tf
        └── waf
            ├── main.tf
            ├── outputs.tf
            └── variables.tf
```

#### Folder Structure
- **Environments** 
  - We will be creating the three folders for Dev, UAT, and Prod for all three environments. 
  - These folders will have the terraform files which will call the modules for deploying the AWS services in the respective environments. 
  - All environments will have different variables, so we can separate the environments based on the variables.
  - The environment directory will have the `main.tf`, `terraform.tfvars`, `provider.tf`, `backend.tf`, `locals.tf` and `variables.tf` files for every environment we will be deploying. 

- **Modules**
  - We will be creating the modules for the services for which we will be deploying the services.
  - This directory will contain the WAF, VPC, Load Balancer, Kubernetes and EKS Module

### Steps to deploy 
- We need to change the directory to the environment we want to deploy.
- Run terraform init
- Run terraform plan -out plan
- Once you find the terraform plan as expected, run `terraform apply plan`. This command will deploy our resources on AWS.

