# Cloud DevOps Engineer Capstone Project

This is the final project for the Udacity Cloud DevOps Engineer Nanodegree. Scope of the project was to design and develop a CircleCI pipeline that will do the following tasks:
- run linter checks on a simple python flask app
- create a docker image of the application
- push the docker image to ECR
- do a rolling deployment into an EKS cluster with the image that was created in the pipeline

## Setup
An EKS cluster was deployed and used for the purpose of the project. 
In order to initialize the cluster, the script  `initialize_eks.sh` under the `scripts` directory was used. The script does the following: 
- uses the `eksctl` utility in order to create the cluster
- uses the `kubectl apply` command for creating an initial deployment and a service for serving the endpoint to outside of the cluster 

The scipt needs the following input: 
- a cluster configuration (example in `eks/cluster.yaml`)
- a  deployment configuration (example in `eks/deployment.yaml`)
- a service configuration (example in `eks/service.yaml`)
- a cluster namespace
- an AWS profile (optional)

The service configuration under `eks/service.yaml` creates a service of type `LoadBalancer` that can be used for accessing the cluster resources from outside the cluster. 

## Pipeline
The CircleCI pipeline consists of the following jobs:
- linter: runs linter checks against the python code and the Dockerfile
- docker-build: builds the docker image and pushes it to an ECR repository
- eks-deploy: does a rolling deployment of the image that was uploaded to ECR repository in the previous step

In order for the pipeline to run successfully, the following **Environment Variables** need to be setup in CircleCI project: 
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_DEFAULT_REGION`
- `ECR_REPOSITORY_URL`
- `EKS_CLUSTER_NAME`
- `EKS_DEPLOYMENT_NAME`
- `EKS_NAMESPACE`
