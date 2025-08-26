pipeline {
    agent any

    environment {
        REGISTRY       = "https://index.docker.io/v1/"
        DOCKERHUB_USER = "suganyamadhan1996"
        IMAGE_NAME     = "login-page"
        DEPLOY_SERVER  = "13.201.20.164"   // Remote EC2 IPp
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
                    docker.withRegistry("${REGISTRY}", '23fd98ca-52b9-4c55-912e-7a95d647e790') {
                        dockerImage.push()
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage('Deploy to Remote EC2') {
            steps {
                script {
                    sshagent (credentials: ['ec2-ssh-key']) {  // Jenkins Credentials ID for your EC2 PEM
                        sh """
                        ssh -o StrictHostKeyChecking=no ubuntu@${DEPLOY_SERVER} '
                            sudo docker pull ${DOCKERHUB_USER}/${IMAGE_NAME}:latest &&
                            sudo docker rm -f myapp || true &&
                            sudo docker run -d -p 8081:80 --name myapp ${DOCKERHUB_USER}/${IMAGE_NAME}:latest
                        '
                        """
                    }
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
