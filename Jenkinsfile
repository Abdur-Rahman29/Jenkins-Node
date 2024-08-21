pipeline {
    agent any

    environment {
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
                    echo 'Running Docker container and testing...'
                    
                    // Run the container in detached mode
                    sh 'docker run -d -p 3000:3000 --name my-node-app-container ${dockerImage}:${dockerTag}'
                    
                    // Wait for a few seconds to ensure the container is up and running
                    sleep(time: 10, unit: 'SECONDS')
                    
                    // Check if the application responds correctly
                    sh 'curl -f http://localhost:3000 || exit 1'

                    // Stop and remove the container
                    sh 'docker stop my-node-app-container'
                    sh 'docker rm my-node-app-container'
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
    
    post {
        always {
            echo 'Cleaning up workspace...'
            deleteDir()
        }
    }
}
