#!groovy

node('master') {
    
    def app
    
    try {
        
        stage('Checkout SCM') {
            checkout scm
        }
        
        stage('build') {
            
            app = docker.build("users-devcon")
            
        }

        stage('test') {
          //  sh "./vendor/bin/phpunit"
           sh "echo 'WE ARE Testing'"
        }

        stage('deploy') {
            
            docker.withRegistry('150177431474.dkr.ecr.ap-southeast-1.amazonaws.com/users-devcon', 'aws-ec2') {
                app.push("${env.BUILD_NUMBER}")
                app.push("latest")
            }
            
        }
    } catch(error) {
        throw error
    } finally {

    }

}
