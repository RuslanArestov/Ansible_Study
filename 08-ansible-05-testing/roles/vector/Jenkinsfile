pipeline {
    agent {
        label 'linux'
    }

    stages {
        stage('Molecule test') {
            steps {
                
                sh '''
                source /opt/molecule-venv/bin/activate
                molecule test
                '''
                
            }
        }
    }
}
