pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    // Build the Docker image with a tag 'latest'
                    
                    docker.build('my-app:latest')
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run tests inside the Docker container
                    docker.image('my-app:latest').inside {
                        sh 'npm test'  // or any other test command
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Define the target image tag for the Docker registry
                    def targetImage = 'abdurmohammed928/my-app:latest'
                    
                    // Tag the built image with the full repository path and tag
                    docker.image('my-app:latest').tag(targetImage)
                    
                    // Push the tagged image to the Docker registry
                    docker.image(targetImage).push()
                }
            }
        }
    }
    
    // Cleanup workspace after the pipeline run
    post {
        always {
            deleteDir()
        }
    }
}
