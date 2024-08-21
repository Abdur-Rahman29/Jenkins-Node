pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    // Build the Docker image with a tag
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
                    // Define the tag for the image
                   
                    
                    // Tag the image with the registry repository and tag
                    docker.image('my-app:latest').tag(imageTag)
                    
                    // Push the tagged image to the Docker registry
                    docker.image(imageTag).push()
                }
            }
        }
    }
}
