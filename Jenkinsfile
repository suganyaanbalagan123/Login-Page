pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-cred') // Jenkins credentials ID
        IMAGE_NAME = "suganyamadhan1996/login-page"
        IMAGE_TAG = "latest"
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
                    sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    sh """
                        echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                        docker push $IMAGE_NAME:$IMAGE_TAG
                    """
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    sh """
                        docker stop login-page || true
                        docker rm login-page || true
                        docker run -d --name login-page -p 8080:80 $IMAGE_NAME:$IMAGE_TAG
                    """
                }
            }
        }
    }

    post {
        failure {
            echo "❌ Pipeline Failed"
        }
        success {
            echo "✅ Pipeline Succeeded"
        }
    }
}
