pipeline {
  agent any

  environment {
        KUBECONFIG = 'C:\\Users\\Lenovo\\.kube\\config'  // Kubernetes config file path
        IMAGE_TAG = "localhost:5000/prasadkale16/sagmsrdemo:${BUILD_NUMBER}" // Dynamic image tag using the build number
    }

  stages {
    stage('build image') {
      steps {
        bat "docker build -t ${IMAGE_TAG} ."
      }
    }
    stage('push image') {
      steps {
        bat "docker push ${IMAGE_TAG}"
      }
    }
    stage('deploy') {
      steps{
        script{
          // PowerShell script to replace the image tag in the deployment.yaml
          bat """
            powershell -Command "(Get-Content deployment.yaml) -replace 'image: .*', 'image: ${IMAGE_TAG}' | Set-Content deployment.yaml"
          """
          // Deploy the updated YAML with the new image tag
          bat 'kubectl apply -f deployment.yaml'
          //kubernetesDeploy configs: 'deployment.yaml', kubeConfig: [path: ''], kubeconfigId: 'kubernetes', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
        }
      }
    }
    stage('service') {
      steps{
        script{
          bat 'kubectl apply -f service.yaml'
          //kubernetesDeploy configs: 'service.yaml', kubeConfig: [path: ''], kubeconfigId: 'kubernetes', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
        }
      }
    }
    stage('ingress') {
      steps {
        bat 'kubectl config use-context docker-desktop'  
        bat 'kubectl apply -f ingress.yaml -n swag-intg --validate=false'
      }
    }
  }
}