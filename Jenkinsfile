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
            
            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {
                app.push("${env.BUILD_NUMBER}")
                app.push("latest")
            }
            
        }
    } catch(error) {
        throw error
    } finally {

    }

}
