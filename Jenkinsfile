pipeline {
    // 1. 指定流水线在哪里运行
    agent any

    // 2. 定义流水线的所有阶段
    stages {
        // 3. 定义一个名为 "Build" 的阶段
        stage('Build') {
            // 4. 定义这个阶段要执行的步骤
            steps {
                echo 'This is the build stage.'
                sh 'ls -la'
            }
        }
        
        // 5. 定义一个名为 "Test" 的阶段
        stage('Test') {
            steps {
                echo 'This is the test stage. Pretending to run tests...'
                sh 'echo "Tests passed!"'
            }
        }
    }
}
