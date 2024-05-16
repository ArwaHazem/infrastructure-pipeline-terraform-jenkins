pipeline {
    agent {
        label 'ec2-public-agent'
    }

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'prod'], description: 'Select the workspace environment')
        choice(name: 'COMMAND', choices: ['apply', 'destroy'], description: 'Select command to perform')
    }

    stages {
        stage('Checkout code') {
            steps {
                git url: 'https://github.com/ArwaHazem/infrastructure-pipeline-terraform-jenkins.git', branch: 'main'

            }
        }

        stage('Initialize Terraform') {
            steps {
                dir('terraform') {
                    script {
                        sh 'terraform init -input=false'
                    }
                }
            }
        }

        stage('Select Workspace') {
            steps {
                dir('terraform') {
                    script {
                        sh "terraform workspace select ${params.ENVIRONMENT} || terraform workspace new ${params.ENVIRONMENT}"
                    }
                }
            }
        }

        stage('Provide Terraform Variables File') {
            steps {
                script {
                    def tfvarsFile = ''
                    if (params.ENVIRONMENT == 'dev') {
                        tfvarsFile = configFile(fileId: 'dev-tfvars', variable: 'TFVARS_FILE')
                    } else if (params.ENVIRONMENT == 'prod') {
                        tfvarsFile = configFile(fileId: 'prod-tfvars', variable: 'TFVARS_FILE')
                    }
                    env.TFVARS_FILE = tfvarsFile
                }
            }
        }

        stage('Execute Terraform') {
            steps {
                dir('terraform') {
                    script {
                        if (params.COMMAND == 'apply') {
                            sh "terraform apply -auto-approve -var-file=${TFVARS_FILE}"
                        } else if (params.COMMAND == 'destroy') {
                            sh "terraform destroy -auto-approve -var-file=${TFVARS_FILE}"
                        }
                    }
                }
            }
        }
    }
}
