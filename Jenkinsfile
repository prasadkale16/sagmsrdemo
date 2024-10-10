pipeline {
  agent any
  stages {
    stage('build image') {
      steps {
        bat 'docker build -t localhost:5000/prasadkale16/sagmsrdemo:123 .'
      }
    }
    stage('push image') {
      steps {
        bat 'docker push localhost:5000/prasadkale16/sagmsrdemo:123'
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
      steps {
        bat 'kubectl --kubeconfig=C:\\Users\\Lenovo\\.kube\\config config use-context docker-desktop'  
        bat 'kubectl --kubeconfig=C:\\Users\\Lenovo\\.kube\\config apply -f ingress.yaml -n swag-intg --validate=false'
      }
    }
  }
}