
pipeline {
    agent any

    environment {
        REGISTRY = "docker.io"
        DOCKERHUB_USER = "suganyamadhan1996"
        IMAGE_NAME = "login-page"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/suganyaanbalagan123/Login-Page.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKERHUB_USER}/${IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry("https://${REGISTRY}", 'dockerhub-cred') {
                        dockerImage.push()
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    // Remove old container if exists
                    sh "docker rm -f login-page || true"

                    // Run latest image
                    sh "docker run -d -p 8081:8080 --name login-page ${DOCKERHUB_USER}/${IMAGE_NAME}:latest"
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build, Push & Deploy Completed"
        }
        failure {
            echo "❌ Pipeline Failed"
        }
    }
}
