#!groovy

node{
  
  def app
  
  stage('Clone Repository') {
    
    checkout scm
  }
  
  stage('Build Image') {
    
    app.inside {
        sh 'echo "test"'
    }
  }
  
   stage('Push Image') {
    
    app.inside {
        sh 'echo "Push"'
    }
  }
  
  

}
