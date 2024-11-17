pipeline {
    agent any

    environment {
        IMAGE_NAME = 'node'
        DOCKER_REGISTRY = 'index.docker.io/v1/'
        REGISTRY_CREDENTIALS = 'docker-hub-credentials'  
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/TahaKilicoglu/next-auth-app-main.git', branch: 'master'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'  // Linux uyumlu komut
            }
        }

        stage('Build Next.js App') {
            steps {
                script {
                    sh 'npm run build'  // Linux uyumlu komut
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry("https://${DOCKER_REGISTRY}", "${REGISTRY_CREDENTIALS}") {
                        sh "docker tag ${IMAGE_NAME}:latest ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
                        sh "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
                    }
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    sh "docker rm -f ${IMAGE_NAME} || true"
                    sh """
                    docker run -d \
                        -p 3000:3000 \
                        --name ${IMAGE_NAME} \
                        ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline tamamlandı!'
        }
        success {
            echo 'Başarıyla tamamlandı!'
        }
        failure {
            echo 'Bir hata oluştu.'
        }
    }
}
