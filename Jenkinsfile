pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    environment {
        DOCKER_IMAGE_REPOSITORY = 'https://028637284133.dkr.ecr.us-east-1.amazonaws.com'
        DOCKER_IMAGE_BUILD_NAME = 'advise_service'
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
                 echo 'Testing 1'
            }
            steps {
                 echo 'Testing 2'
            }
        }
        stage('Deploy to ECR') {
            steps {
                script{
                        docker.withRegistry("${DOCKER_IMAGE_REPOSITORY}", "ecr:${ECR_REGION}:${AWS_JENKINS_CREDS}") {
                    app.push("${env.ENVIRONMENT}_${env.BUILD_NUMBER}")
                    app.push("${env.ENVIRONMENT}_latest")
                    }
                }
            }
        }
        stage('Run Container on the Server'){
             //def dockerRun = 'docker run -p 8080:8080 -d --name my-app kammana/my-app:2.0.0'
             //def dockerRun = 'docker-compose run -d advise-service'
            def dockerRun = 'pwd'
             
             sshagent(['devops_ci_cd_pipeline']) {
               sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.26.242 ${dockerRun}"
             }
           }            
        
        
    }
}
