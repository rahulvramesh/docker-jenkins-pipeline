#!groovy

node('master') {
    
    def app
    
    try {
        
        stage('Checkout SCM') {
            checkout scm
        }
        
        stage('build') {
            
            app = docker.build("rahulevhive/demo")
            
        }

        stage('test') {
          //  sh "./vendor/bin/phpunit"
           sh "echo 'WE ARE Testing'"
        }

        stage('deploy') {
            
            docker.withRegistry('https://registry.hub.docker.com', '9d4c9d4d-61c4-476b-aad1-f34145ecfa9c') {
                app.push("${env.BUILD_NUMBER}")
                app.push("latest")
            }
            
        }
    } catch(error) {
        throw error
    } finally {

    }

}
