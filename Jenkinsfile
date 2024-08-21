pipeline {
    agent any

    environment {
        // Define environment variables
        dockerImage = 'my-app'
        dockerTag = 'latest'
        targetImage = 'abdurmohammed928/my-app:latest'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    echo 'Building Docker image...'
                    // Build the Docker image with the tag 'latest'
                    docker.build("${dockerImage}:${dockerTag}")
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    echo 'Running tests inside Docker container...'
                    // Run the container and test it
                    docker.image("${dockerImage}:${dockerTag}").inside {
                        // Check if the application responds correctly
                        sh 'curl -f http://localhost:3000'  // Fail if the application does not respond with 'hello-world'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo 'Tagging and pushing Docker image...'
                    // Tag the built image with the target repository path and tag
                    sh "docker tag ${dockerImage}:${dockerTag} ${targetImage}"
                    
                    // Log in to Docker Hub (Ensure you have Docker Hub credentials configured)
                    withDockerRegistry([credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/']) {
                        // Push the tagged image to the Docker registry
                        sh "docker push ${targetImage}"
                    }
                }
            }
        }
    }
    
    // Cleanup workspace after the pipeline run
    post {
        always {
            echo 'Cleaning up workspace...'
            deleteDir()
        }
    }
}
