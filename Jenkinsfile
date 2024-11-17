pipeline {
    agent any

    environment {
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'
        DOCKER_COMPOSE = 'docker-compose'  // Eğer docker-compose terminalde çalışıyorsa, burada sadece 'docker-compose' yazabilirsiniz
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker images...'
                sh '${DOCKER_COMPOSE} -f ${DOCKER_COMPOSE_FILE} build'
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Running tests...'
                sh '${DOCKER_COMPOSE} -f ${DOCKER_COMPOSE_FILE} run --rm app npm test'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                sh '${DOCKER_COMPOSE} -f ${DOCKER_COMPOSE_FILE} up -d'
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            sh '${DOCKER_COMPOSE} -f ${DOCKER_COMPOSE_FILE} down || true'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
