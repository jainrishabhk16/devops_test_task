pipeline {
    agent any

    parameters {
        choice(name: 'ENV', choices: ['DEV', 'UAT', 'PROD'], description: 'Choose the deployment environment')
        string(name: 'IMAGE_TAG', choices: ['DEV', 'UAT', 'PROD'], description: 'Docker image tag to use')
    }

    environment {
        REGISTRY = 'my-docker-registry.com' // URL for ECR repo
        APP_NAME = 'nodejs-app'
        WORKSPACE = "${env.WORKSPACE}" // Jenkins workspace
        TERRAFORM_DIR = "terraform/${params.ENV.toLowerCase()}"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code..."
                checkout scm
            }
        }

        // Building base eveytime
        stage('Docker Build and Push') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh "docker build -t ${REGISTRY}/${APP_NAME}:${IMAGE_TAG} ."

                    // echo "Pushing Docker image to registry..."
                    // sh "docker push ${REGISTRY}/${APP_NAME}:${IMAGE_TAG}"
                }
            }
        }

        stage('Build and push Development environment') {
            when { expression { params.ENV == 'DEV' } }
            steps {
                echo "Building Node.js application..."
                sh "docker build --target development -t ${REGISTRY}/${APP_NAME}:${IMAGE_TAG} ."
                
                echo "Pushing the dev image"
                sh "docker push ${REGISTRY}/${APP_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Build and push UAT environment') {
            when { expression { params.ENV == 'UAT' } }
            steps {
                echo "Building Node.js application..."
                sh "docker build --target uat -t ${REGISTRY}/${APP_NAME}:${IMAGE_TAG} ."
                
                echo "Pushing the dev image"
                sh "docker push ${REGISTRY}/${APP_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Build and push Production environment') {
            when { expression { params.ENV == 'PROD' } }
            steps {
                echo "Building Node.js application..."
                sh "docker build --target production -t ${REGISTRY}/${APP_NAME}:${IMAGE_TAG} ."
                
                echo "Pushing the dev image"
                sh "docker push ${REGISTRY}/${APP_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    echo "Initializing Terraform for ${params.ENV}..."
                    dir(TERRAFORM_DIR) {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    echo "Planning Terraform changes for ${params.ENV}..."
                    dir(TERRAFORM_DIR) {
                        sh "terraform plan -var='environment=${params.ENV}' -var='image_tag=${IMAGE_TAG}'"
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    echo "Applying Terraform changes for ${params.ENV}..."
                    dir(TERRAFORM_DIR) {
                        sh "terraform apply -auto-approve -var='environment=${params.ENV}' -var='image_tag=${IMAGE_TAG}'"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Deployment to ${params.ENV} environment succeeded!"
        }
        failure {
            echo "Deployment to ${params.ENV} environment failed!"
        }
    }
}

