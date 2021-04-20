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
    }
    stages {
        stage ("Release") {
        }
    }
    post {
        failure {
            script {
                shared.notifyTeams('FAILED', shared.teamsWebhooks('tim').alerts)
            }
        }
        fixed {
            script {
                shared.notifyTeams('SUCCESS', shared.teamsWebhooks('tim').alerts)
            }
        }
    }
}
