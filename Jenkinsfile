pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    environment {
        DOCKER_IMAGE_REPOSITORY = 'https://028637284133.dkr.ecr.us-east-1.amazonaws.com'
        DOCKER_IMAGE_BUILD_NAME = 'advise_service_dev'
        ECR_REGION = 'us-east-1'        
        AWS_JENKINS_CREDS = 'turndevops_aws_creds'
    }
    stages {
         stage('Clone repository') { 
            steps { 
                script{
                checkout scm
                }
            }
        }

        stage('Build') { 
            steps { 
                script{
                 app = docker.build("${DOCKER_IMAGE_BUILD_NAME}")
                }
            }
        }
        stage('Test'){
            steps {
                 echo 'Testing...'
            }
        }
        stage('Deploy') {
            steps {
                script{
                        docker.withRegistry("${DOCKER_IMAGE_REPOSITORY}", "ecr:${ECR_REGION}:${AWS_JENKINS_CREDS}") {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                    }
                }
            }
        }
    }
}
