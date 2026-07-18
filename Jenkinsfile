node {
   stage('Checkout') {
        checkout scm
    }
   
    stage('Build Docker Image') {
        sh "docker build -t ${JOB_NAME}:v1.${BUILD_ID} ."
    }

   stage("Tag Image") {
        sh "docker tag ${JOB_NAME}:v1.${BUILD_ID} vivekbhardwaj581/${JOB_NAME}:v1.${BUILD_ID}"
        sh "docker tag ${JOB_NAME}:v1.${BUILD_ID} vivekbhardwaj581/${JOB_NAME}:latest"
    } 

   stage("Docker Login") {
    withCredentials([string(credentialsId: 'dockerhubpassword', variable: 'dockerhubpassword')]) {
    // some block
     sh "docker login -u vivekbhardwaj581 -p ${dockerhubpassword}"
}
    }

   stage("Push Image on docker hub"){
        sh "docker push vivekbhardwaj581/${JOB_NAME}:v1.${BUILD_ID}"
         sh "docker push vivekbhardwaj581/${JOB_NAME}:latest"
    } 

   stage("Cleanup"){
        sh "docker rmi ${JOB_NAME}:v1.${BUILD_ID}"
        sh "docker rmi vivekbhardwaj581/${JOB_NAME}:v1.${BUILD_ID}"
    }

      
stage("Deploy the Container"){
    sshagent(['jenkinskey']) {

        sh '''
        ssh -o StrictHostKeyChecking=no ec2-user@35.178.202.235 "
        docker stop webcontainer || true
        docker rm webcontainer || true
        docker run -p 8000:80 -itd --name webcontainer vivekbhardwaj581/two-tier-resourcespace
        "
        '''
    }
}
}

