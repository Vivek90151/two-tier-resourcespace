node {
stage('Checkout') {
        checkout scm
    }

        stage('Build Docker Image') {
        sh "docker build -t ${JOB_NAME}:v1.${BUILD_ID} ."
    }

        
     
}
