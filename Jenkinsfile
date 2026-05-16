pipeline {
    // Run this pipeline on your local Mac environment
    agent any 

    stages {
        stage('Environment Check') {
            steps {
                echo ' Checking what tools are available on my Mac...'
                sh 'sw_vers'      // Prints your macOS version
                sh 'git --version' // Prints your local Git version
            }
        }

        stage('Build') {
            steps {
                echo '🔨 Simulating a build phase...'
                // If you are using Node, you could run: sh 'npm install'
                sh 'echo "Compile complete!"'
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Running tests...'
                // Example: sh 'npm test' or custom test scripts
                sh 'echo "All tests passed successfully!"'
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 Deploying locally...'
                sh 'echo "Application deployed successfully to localhost!"'
            }
        }
    }

    // This section runs automatically after the stages complete
    post {
        success {
            echo '🎉 Success! The entire pipeline completed cleanly.'
        }
        failure {
            echo '❌ Uh oh! Something in the pipeline broke.'
        }
    }
}