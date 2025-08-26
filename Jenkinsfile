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
                    docker.withRegistry("https://${REGISTRY}", '23fd98ca-52b9-4c55-912e-7a95d647e790') {
                        dockerImage.push()
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    sh "docker rm -f myapp || true"
                    sh "docker run -d -p 8081:80 --name myapp ${DOCKERHUB_USER}/${IMAGE_NAME}:latest"
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
