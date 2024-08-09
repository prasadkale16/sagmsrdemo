pipeline {
  agent any
  environment {
    IMAGE_NAME='prasadkale16/sagmsrdemo'
    IMAGE_VERSION='0.1.1'
  }
  stages {
    stage('build image') {
      steps {
        sh 'docker build -t $IMAGE_NAME:$IMAGE_VERSION .'
      }
    }
    stage('tag image') {
      steps {
        sh 'docker tag $IMAGE_NAME:$IMAGE_VERSION localhost:5000/$IMAGE_NAME:$IMAGE_VERSION'
      }
    }
    stage('push image') {
      steps {
        sh 'docker push localhost:5000/$IMAGE_NAME:$IMAGE_VERSION'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}