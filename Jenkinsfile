pipeline {
    agent any

    environment {
        dockerImage=''
        registry = 'bandhu8/hello:latest'
        repoUrl = 'https://github.com/samratsapkota/samratsapkota.git'
        branchName = 'staging'
        registryCredential = 'tododockerhub'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: "${branchName}", url: "${repoUrl}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${registry}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                        docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                        dockerImage.push()
                    }
                }
        }
    }
    }
}