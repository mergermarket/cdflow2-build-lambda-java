// variables
def version

@Library(value='jenkins-shared-library', changelog=false) _

pipeline {
    options {
        timestamps()
        ansiColor('xterm')
        disableConcurrentBuilds()
    }
    agent { node { label "swarm2" } }
    stages {
        stage ("Release") {
            steps {
                sh 'echo "this jenkins job does not do anything yet"'
            }
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
