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
        }
      }
    }
    stage('service') {
      steps{
        script{
          bat 'kubectl apply -f service.yaml'
        }
      }
    }
    stage('ingress') {
      steps {
        bat 'kubectl config use-context docker-desktop'  
        bat 'kubectl apply -f ingress.yaml -n swag-intg --validate=false'
      }
    }
    stage('Verify Deployment') {
      steps {
        script {
          // Simple check if deployment was successful (replace with more detailed logic if needed)
          def deploymentStatus = bat(script: 'kubectl get pods --selector=app=msr-k8s -n swag-intg', returnStatus: true)
          if (deploymentStatus != 0) {
            currentBuild.result = 'FAILURE'
            error("Deployment failed.")
          }
        }
      }
    }
    stage('User Satisfaction') {
      steps {
        script {
          // Ask user if they are satisfied with the result
          def userInput = input message: 'Are you satisfied with the deployment?', ok: 'Proceed', parameters: [choice(name: 'Proceed with deployment?', choices: 'Yes\nNo', description: '')]
          if (userInput == 'No') {
            error("User is not satisfied with the deployment.")
          }
        }
      }
    }
  }
  post {
    failure {
      script {
        // Get current revision of the deployment
        def rolloutHistory = sh(script: "kubectl rollout history deployment/msr-k8s-deployment -n swag-intg", returnStdout: true).trim()

        // Parse the rollout history to get the current revision
        def revisions = []
        rolloutHistory.eachLine { line ->
          if (line.startsWith("deployment.apps")) {
            // Ignore header line
          } else if (line =~ /REVISION/) {
            // Ignore the title line
          } else {
            // Extract revision number from the list
            def revision = (line.split()[0]).toInteger()
            revisions.add(revision)
          }
        }

        // Sort revisions in reverse order to get the last one (which is the current)
        revisions = revisions.sort().reverse()

        // Current revision would be the first item in the list
        def currentRevision = revisions[0]

        // Rollback to the previous revision if exists
        if (revisions.size() > 1) {
          def previousRevision = revisions[1]
          bat "kubectl rollout undo deployment/msr-k8s-deployment -n swag-intg --to-revision=${previousRevision}"
          echo "Rolled back to revision ${previousRevision}."
        } else {
          echo "No previous revision to roll back to."
        }
      }
      script {
        // Delete the Docker image if the build fails
        echo "Deleting Docker image ${IMAGE_TAG}..."
        bat "docker rmi ${IMAGE_TAG} || echo 'Image not found or could not be deleted'"
      }
    }
    always {
      script {
        wsCleanup()
        if (currentBuild.result == 'FAILURE') {
          echo "Cleaning up failed build."
            // Implement build cleanup logic here if necessary
            echo "Deleting Docker image ${IMAGE_TAG}..."
            bat "docker rmi ${IMAGE_TAG} || echo 'Image not found or could not be deleted'"
        }
      }
    } 
  }
}