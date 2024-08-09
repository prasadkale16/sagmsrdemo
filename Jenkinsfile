pipeline {
  agent any
  stages {
    stage('build image') {
      steps {
        bat 'docker build -t prasadkale16/sagmsrdemo:0.0.1 .'
      }
    }
  }
}