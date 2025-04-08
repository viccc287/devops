pipeline {
    agent any
    
    environment {
        IMAGE_NAME = 'sicei'
        CONTAINER_NAME = 'sicei'
        TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Build') {
            steps {
                dir('sicei') {
                    echo "Building Docker image with tag: ${TAG}"
                    bat "docker build -t ${IMAGE_NAME}:${TAG} ."
                }
            }
        }
        
        stage('Deploy') {
            steps {
                dir('sicei') {
                    echo "Stopping and removing previous container if exists..."
                    bat "for /f \"tokens=*\" %%i in ('docker ps -q --filter \"name=${CONTAINER_NAME}\"') do docker stop %%i"
                    bat "for /f \"tokens=*\" %%i in ('docker ps -a -q --filter \"name=${CONTAINER_NAME}\"') do docker rm %%i"
                    
                    echo "Deploying new image..."
                    bat "docker run -d -p 3000:3000 --name ${CONTAINER_NAME} ${IMAGE_NAME}:${TAG}"
                    
                    echo "Process completed. Image: ${IMAGE_NAME}:${TAG} is running."
                }
            }
        }
    }
    
    post {
        success {
            echo "Pipeline executed successfully!"
        }
        failure {
            echo "Pipeline failed. Please check the logs."
        }
    }
}