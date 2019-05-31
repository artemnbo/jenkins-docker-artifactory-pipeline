def sonarProjectKey = 'testProject'
def sonarProjectName = 'TestProject'
def sonarProjectVersion = '1.0' 
def sonarProjectSource = '.'

pipeline {
    agent {
        dockerfile {
            dir '.'
            filename 'Dockerfile'
            additionalBuildArgs '--build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g)'
            label 'jenkins-slave'
        }
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('SonarQube Code analysis'){
            steps {
              script {
                    withSonarQubeEnv('SonarQube Server') {
                        sh '${SONAR_RUNNER_HOME}/bin/sonar-scanner -Dsonar.projectKey=' + sonarProjectKey + ' -Dsonar.projectName=' + sonarProjectName + ' -Dsonar.projectVersion=' + sonarProjectVersion + ' -Dsonar.sources=' + sonarProjectSource
                    }
                }
            }
        }
        
        stage("Quality Gate"){
           steps {
                script {
                
                    timeout(time: 160, unit: 'SECONDS') {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }
        }
    }
    
    post {
        always {
            deleteDir()
            
        }
    }   
}