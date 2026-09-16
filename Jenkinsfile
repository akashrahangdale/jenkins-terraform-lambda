pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Package Lambda') {
            steps {
                sh '''
                    rm -f terraform/lambda_function.zip
                    zip -j terraform/lambda_function.zip app.py
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Terraform Output') {
            steps {
                dir('terraform') {
                    sh 'terraform output'
                }
            }
        }
    }

    post {
        success {
            echo '🚀 Lambda infrastructure deployed successfully!'
        }

        failure {
            echo '❌ Lambda deployment failed!'
        }
    }
}
