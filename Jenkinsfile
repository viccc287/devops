pipeline {
    agent any
    
    environment {
        IMAGE_NAME = 'sicei'
        CONTAINER_NAME = 'sicei'
        TAG = "${BUILD_ID}"
    }
    
    stages {
        stage('Build') {
            when {
                changeset "sicei/**"
            }
            steps {
                dir('sicei') {
                    bat "echo Construyendo la imagen Docker con tag: %TAG%"
                    bat "docker build -t ${IMAGE_NAME}:${TAG} ."
                }
            }
        }
        
        stage('Deploy') {
            when {
                changeset "sicei/**"
            }
            steps {
                bat '''
                    echo Deteniendo y eliminando el contenedor anterior si existe...
                    for /f "tokens=*" %%i in ('docker ps -q --filter "name=%CONTAINER_NAME%"') do docker stop %%i
                    for /f "tokens=*" %%i in ('docker ps -a -q --filter "name=%CONTAINER_NAME%"') do docker rm %%i
                '''
                
                bat "echo Desplegando la nueva imagen..."
                bat "docker run -d -p 3000:3000 --name ${CONTAINER_NAME} ${IMAGE_NAME}:${TAG}"
                
                echo "Proceso completado. Imagen: ${IMAGE_NAME}:${TAG} en ejecución."
            }
        }
    }
}