pipeline {
    agent any

    environment {
        IMAGE_NAME = 'ayaacvia/gireact-native-redux-calculator'
        REGISTRY = 'index.docker.io/v1'
        REGISTRY_CREDENTIALS = 'dockerhub-credentials' // Ganti dengan ID credential Jenkins yang benar
    }
}
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
    }