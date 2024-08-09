pipeline {
  agent any
  stages {
    stage('build image') {
      steps {
        bat 'docker build -t localhost:5000/prasadkale16/sagmsrdemo .'
      }
    }
    stage('push image') {
      steps {
        bat 'docker push localhost:5000/prasadkale16/sagmsrdemo'
      }
    }
    stage('deploy to k8s') {
      steps{
        script{
          kubernetesDeploy configs: 'deploymentservice.yaml', kubeConfig: [path: ''], kubeconfigId: 'kubernetes', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
        }
      }
    }
  }
}