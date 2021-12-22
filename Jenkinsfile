pipeline {
  environment {
    registry = "https://hub.docker.com/r/kamaljits/laravel"
    registryCredential = 'dockerhub'
  }
  agent any
  stages {
     stage('Initialize'){
        def dockerHome = tool 'myDocker'
        env.PATH = "${dockerHome}/bin:${env.PATH}"
    }
    stage('Building image') {
      steps{
        script {
          docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
  }
}