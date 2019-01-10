#!/usr/bin/env groovy
@Library('digital-jenkins-library@master')
def digitalCommands = new com.digital.jenkins.DigitalCommands()

podTemplate(
        label: 'amazon-sqs-java-messaging-lib',
        containers: [
                containerTemplate(
                        name: 'java',
                        image: 'java:8-jdk',
                        ttyEnabled: true,
                        command: 'cat'
                ),
        ]
) {

    node('springboot-lib') {
        def varSCM = checkout scm

        stage('Build and Test') {
            try {
                container('java') {
                    sh('mvn install -DskipTests')
                }
            } finally {
                junit '**/test-results/*.xml'
            }
        }

        stage('Publish Version From Master') {
            if (varSCM.GIT_BRANCH == 'master') {
                container('java') {
                    sh('./publishRelease.sh')
                }
            } else {
                sh("echo 'Version not published because branch is not master.'")
            }
        }
    }
}