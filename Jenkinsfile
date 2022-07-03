pipeline {
    agent any
    parameters {
        string defaultValue: 'example-app', name: 'IMAGE_NAME', trim: true
        string defaultValue: 'latest', name: 'IMAGE_TAG', trim: true
    }

    environment {
        // GIT_URL = 'https://github.com/skorobkov/react-redux-realworld-example-app'
        GIT_URL = 'git@github.com:skorobkov/react-redux-realworld-example-app-private.git'
        GITHUB_CRED_ID = 'github-cred'
        ECR_URL = 'https://278059957414.dkr.ecr.eu-west-1.amazonaws.com/example-app'
        ECR_CRED = 'ecr:eu-west-1:aws-creds'
    }

    stages {
        stage('SCM') {
            steps {
                git credentialsId: "${GITHUB_CRED_ID}", url: "${GIT_URL}"
            }
        }
        stage('BUILD') {
            steps {
                script {
                    image = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }
        stage('PUSH') {
            steps {
                script {
                    docker.withRegistry("${ECR_URL}", "${ECR_CRED}") {
                        image.push("${IMAGE_TAG}")
                    }
                }
            }
        }
    }
}
