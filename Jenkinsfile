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

        stage('Publish package to Artifactory') {
            steps {
                script {
                    zmsg = sh returnStdout: true, script: "zip -r package.zip src/*"
                    print zmsg
                    def branch = env.GIT_BRANCH.tokenize('/').last()
                    def server = Artifactory.server 'JFrog Artifactory Server'
                    def uploadSpec = """{
                        "files": [
                            {
                                "pattern": "package.zip",
                                "target": "local-repo/testPrj/${branch}/testPrj-${env.BUILD_NUMBER}-${env.BUILD_TIMESTAMP}.zip"
                            }
                        ]
                    }"""
                    server.upload(uploadSpec)
                    sh 'rm -v package.zip'
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