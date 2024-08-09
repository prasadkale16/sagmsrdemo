pipeline {
  agent any
  stages {
    stage('build image') {
      steps {
        bat 'docker build -t prasadkale16/sagmsrdemo .'
      }
    }
    stage('push image') {
      steps {
        bat 'docker push localhost:5000/prasadkale16/sagmsrdemo'
      }
    }
  }
}