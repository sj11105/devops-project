pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/sj11105/devops-project.git'
        IMAGE_NAME = 'sneha1101/flask-app'
        IMAGE_TAG = 'latest'  // You can replace with "${BUILD_NUMBER}" for versioning
        AWS_REGION = 'ap-south-1'
    }

    stages {
        stage('Clone from GitHub') {
            steps {
                git url: "${env.GIT_REPO}", branch: 'main'
            }
        }

        stage('Terraform Provisioning') {
            environment {
                AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
                AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
            }
            steps {
                dir('terraform') {
                    bat '''
                        terraform init
                        terraform apply -auto-approve
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                bat '''
                    docker build -t %IMAGE_NAME%:%IMAGE_TAG% ./app
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'DockerHub',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat '''
                        echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                        docker push %IMAGE_NAME%:%IMAGE_TAG%
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    bat 'kubectl apply -f deployment/deployment.yaml'
                    bat 'kubectl apply -f deployment/service.yaml'
                }
            }
        }
    }

    post {
        always {
            withCredentials([
                string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
            ]) {
                dir('terraform') {
                    bat '''
                        echo "Waiting 5 minutes before destroying resources..."
                        powershell -command "Start-Sleep -Seconds 300"
                        terraform destroy -auto-approve
                    '''
                }
            }
        }
    }
}
