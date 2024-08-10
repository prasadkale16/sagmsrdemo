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
    stage('deploy') {
      steps{
        script{
          kubernetesDeploy configs: 'deployment.yaml', kubeConfig: [path: ''], kubeconfigId: 'kubernetes', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
        }
      }
    }
    stage('service') {
      steps{
        script{
          kubernetesDeploy configs: 'service.yaml', kubeConfig: [path: ''], kubeconfigId: 'kubernetes', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
        }
      }
    }
    stage('ingress') {
      steps{
        bat 'kubectl apply -f ingress.yaml -n default'
      }
    }
  }
}