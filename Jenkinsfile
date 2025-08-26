pipeline {
    agent any

    environment {
        REGISTRY       = "https://index.docker.io/v1/"
        DOCKERHUB_USER = "suganyamadhan1996"
        IMAGE_NAME     = "login-page"
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
                    // Build with build number as a tag
                    dockerImage = docker.build("${DOCKERHUB_USER}/${IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry("${REGISTRY}", '23fd98ca-52b9-4c55-912e-7a95d647e790') {
                        // Push both the build number and 'latest'
                        dockerImage.push()
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    // Stop and remove old container if exists, then run new one
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
