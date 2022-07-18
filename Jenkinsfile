pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
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
                 app = docker.build("advise_service")
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
                        docker.withRegistry('https://028637284133.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:turndevops_aws_creds') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                    }
                }
            }
        }
    }
}
