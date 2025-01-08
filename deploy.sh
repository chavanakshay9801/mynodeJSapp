#!/bin/bash

# Authenticate with ECR
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin <ECR_REPOSITORY_URI>

# Build and push the Docker image
docker build -t <ECR_REPOSITORY_URI>:latest .
docker push <ECR_REPOSITORY_URI>:latest

# Update ECS service
aws ecs update-service --cluster nodejs-cluster --service nodejs-service --force-new-deployment
