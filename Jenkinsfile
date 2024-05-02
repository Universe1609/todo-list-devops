pipeline{
    agent any
    tools {
        jdk 'jdk'
        nodejs 'nodejs_18'
    }

    environment {
        SCANNER_HOME=tool 'sonar-scanner'
        DOCKERFILE_NAME='todo-list-app'
    }
    stages{
        stage("Clean WorkSpace"){
            steps{
                cleanWs()
            }
        }

        stage("Checkout Git"){
            steps{
                git branch: 'main', url: 'https://github.com/Universe1609/todo-list-devops'
            }
        }

        stage("Análisis Sonarqube") {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner \
                    -Dsonar.projectName=todo-list-app \
                    -Dsonar.projectKey=todo-list-app'''
                }
            }
        }

        stage("Quality Check") {
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar'
                }
            }
        }

        stage("Escaneo de Dependencias OWASP") {
            steps {
                dependencyCheck additionalArguments: ''' -o './'
                                                        -s './'
                                                        -f 'ALL'
                                                        --prettyPrint''', odcInstallation: 'DP-Check'
                dependencyCheckPublisher pattern: 'dependency-check-report.xml'
            }
        }

        stage("Filesystem scanning con Trivy") {
            steps {
                sh 'trivy fs . > trivyfs-scanning-todo-list-app-${BUILD_NUMBER}-${BUILD_ID}.txt'
            }
        }

        stage("Compilacion de la Imagen docker") {
            steps {
                script {
                    sh 'docker system prune -f'
                    sh 'docker build -t ${DOCKERFILE_NAME} .'
                }
            }
        }

        stage("Docker image scanning con Trivy") {
            steps {
                sh 'trivy image ${DOCKERFILE_NAME} > trivyimage-scanning-todo-list-app-${BUILD_NUMBER}-${BUILD_ID}.txt'
            }
        }


    }
    post{
        always{
            script {
                emailext attachLog: true,
                    subject: "'${currentBuild.result}'",
                    body: "Project: ${env.JOB_NAME}" + "Build Number: ${BUILD_NUMBER}" + "URL: ${BUILD_URL} ",
                    to: "cloudgroupuni@gmail.com",
                    attachmentsPattern: 'trivyimage-scanning-todo-list-app-*.txt, trivyfs-scanning-todo-list-app-*.txt, dependency-check-report.xml'
            }
        }
    }
}