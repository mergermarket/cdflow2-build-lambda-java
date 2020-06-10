// variables
def version

@Library(value='jenkins-shared-library', changelog=false) _

pipeline {
    options {
        timestamps()
        ansiColor('xterm')
        disableConcurrentBuilds()
    }
    agent none
    environment {
        AWS_CREDS = credentials("aws-credentials")
        AWS_ACCESS_KEY_ID = "${env.AWS_CREDS_USR}"
        AWS_SECRET_ACCESS_KEY = "${env.AWS_CREDS_PSW}"
    }
    stages {
        stage ("Release") {
            when {
                branch "master"
            }
            agent { node { label "swarm2" } }
            steps {
                script {
                    version = shared.getVersion(env.BUILD_NUMBER)
                }
                sh "cdflow2 release ${version}"
            }
        }
        stage ("Deploy to aslive") {
            when {
                branch "master"
            }
            agent { node { label "swarm2" } }
            steps {
                sh "cdflow2 deploy aslive ${version}"
            }
        }
        stage ("Deploy to live") {
            when {
                branch "master"
            }
            agent { node { label "swarm2" } }
            input { message "Proceed to live?" }
            steps {
                sh "cdflow2 deploy live ${version}"
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