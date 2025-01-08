pipeline {
    agent any
    environment {
        ECR_REPO_URI = '<ECR_REPOSITORY_URI>'
        AWS_REGION = 'us-east-2'
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', credentialsId: 'github-credentials', url: '<GITHUB_REPO_URL>'
            }
        }
        stage('Build and Test') {
            steps {
                sh 'npm install'
                sh 'npm test'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $ECR_REPO_URI:latest .'
            }
        }
        stage('Push Docker Image to ECR') {
            steps {
                script {
                    sh '''
                    aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO_URI
                    docker push $ECR_REPO_URI:latest
                    '''
                }
            }
        }
        stage('Deploy to ECS') {
            steps {
                sh '''
                aws ecs update-service --cluster nodejs-cluster --service nodejs-service --force-new-deployment
                '''
            }
        }
    }
}
