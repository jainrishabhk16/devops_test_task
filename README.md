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

### Added Dockerfile
- Created a `Dockerfile` will allow us to build the docker image for the application. We will be using the .env file to pass on the environment variables to build images for different environments.

### Terraform
- We will be creating terraform modules to deploy services on aws. We will be creating modules for deploying our application on AWS EKS cluster. 
- We will be adding modules for EKS, VPC, Load balancing. 

```bash
.
├── environments
│   ├── dev
│   ├── prod
│   └── uat
└── modules
    ├── eks
    ├── iam
    ├── load_balancer
    └── vpc
```

#### Folder Structure
- **Environments** 
  - We will be creating the three folders for Dev, UAT, and Prod for all three environments. 
  - These folders will be having the terraform files which will be calling the modules for deploying the AWS services in the respective environments. 
  - All environments will be having different variables, so we can separate the environments based on the variables. 

- **Modules**
  - We will be creating the modules for the services which we will be deploying the services.  

