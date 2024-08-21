pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    docker.build('my-app')
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    docker.image('my-app').inside {
                        sh 'npm test'  // or any other test command
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    docker.image('my-app').push('abdurmohammed928/my-app')
                }
            }
        }
    }
}
