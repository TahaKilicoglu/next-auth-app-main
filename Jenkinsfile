pipeline {
    agent any

    environment {
        IMAGE_NAME = 'node'
        DOCKER_REGISTRY = 'your-docker-registry' // Docker Hub veya özel bir kayıt
        REGISTRY_CREDENTIALS = 'docker-registry-credentials-id' // Jenkins'te tanımlı docker kimliği
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Git repo kodunu klonlama
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Next.js bağımlılıklarını yükleme
                    sh 'npm install'
                }
            }
        }

        stage('Build Next.js App') {
            steps {
                script {
                    // Next.js üretim için optimizasyon yapma
                    sh 'npm run build'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Docker imajını oluşturma
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Docker Hub veya özel bir kayda giriş
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
                    // Önceki konteynerı durdurup silme
                    sh "docker rm -f ${IMAGE_NAME} || true"

                    // Yeni konteyneri çalıştırma
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
            // İşlem bitince durumu yazdır
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
