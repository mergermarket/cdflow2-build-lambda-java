// variables
def version

@Library(value='jenkins-shared-library', changelog=false) _

pipeline {
    options {
        timestamps()
        ansiColor('xterm')
        disableConcurrentBuilds()
    }
    agent {
        kubernetes {
            label shared.getNodeLabel(env.JOB_NAME)
            yaml shared.getPodTemplate(env.JOB_NAME)
        }
    }
    environment {
        AWS_CREDS = credentials("aws-credentials")
        AWS_ACCESS_KEY_ID = "${env.AWS_CREDS_USR}"
        AWS_SECRET_ACCESS_KEY = "${env.AWS_CREDS_PSW}"
    }
    stages {
        stage ("Test") {
            steps {
                container('cdflow') {
                    test()
                }
            }
        }
        stage ("Release") {
            when {
                branch "master"
            }
            steps {
                container('cdflow') {
                    script {
                        shared.checkoutPlatformConfig("%{account_prefix}-platform-config")
                        version = shared.getVersion(env.BUILD_NUMBER)
                    }
                    sh "cdflow release --platform-config ./platform-config ${version}"
                }
            }
        }
        stage ("Deploy to aslive") {
            when {
                branch "master"
            }
            steps {
                container('cdflow') {
                    sh "cdflow deploy aslive ${version}"
                }
            }
        }
        stage ("Deploy to live") {
            when {
                branch "master"
            }
            steps {
                container('cdflow') {
                    sh "cdflow deploy live ${version}"
                }
            }
        }
    }
    post {
        failure {
            script {
                shared.notifySlack("FAILURE", "#%{team}-team-alerts")
            }
        }
        fixed {
            script {
                shared.notifySlack("SUCCESS", "#%{team}-team-alerts")
            }
        }
    }
}

// reusable code
def test() {
    checkout scm
    // sh "./test.sh"
}
