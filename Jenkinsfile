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
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Select Workspace') {
            steps {
                dir('terraform') {
                    sh "terraform workspace select ${params.ENVIRONMENT} || terraform workspace new ${params.ENVIRONMENT}"
                }
            }
        }

        stage('Provide Terraform Variables File') {
            steps {
                script {
                    def tfvarsFileId = "${params.ENVIRONMENT}-tfvars"
                    configFileProvider([configFile(fileId: tfvarsFileId, variable: 'TFVARS_FILE')]) {
                        script {
                            sh "cp ${TFVARS_FILE} terraform/${params.ENVIRONMENT}.tfvars"
                            env.TFVARS_FILE = "${params.ENVIRONMENT}.tfvars"
                        }
                    }
                }
            }
        }

        stage('Execute Terraform') {
            steps {
                dir('terraform') {
                    script {
                        echo "Executing Terraform ${params.COMMAND} with variables from ${env.TFVARS_FILE}"
                        if (params.COMMAND == 'apply') {
                            sh "terraform apply -auto-approve -var-file=${env.TFVARS_FILE}"
                        } else if (params.COMMAND == 'destroy') {
                            sh "terraform destroy -auto-approve -var-file=${env.TFVARS_FILE}"
                        }
                    }
                }
            }
        }
    }
}
