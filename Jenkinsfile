pipeline {
    // 1. 指定 agent 和 tools
    agent {
        // 在任何 agent 上运行
        any
    }
    tools {
        // 声明我们将使用一个名为 'maven-3.8.6' 的 Maven 工具
        // 这个名字必须和我们在 Jenkins 全局工具中配置的名字完全一致
        maven 'maven-3.8.6'
    }

    // 2. 定义流水线阶段
    stages {
        stage('Compile') {
            steps {
                echo 'Compiling the application...'
                // 使用 mvn 命令进行编译
                sh 'mvn compile'
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
                // 使用 mvn 命令运行测试
                sh 'mvn test'
            }
        }
        stage('Package') {
            steps {
                echo 'Packaging the application...'
                // 使用 mvn 命令打包成 jar 文件
                sh 'mvn package'
            }
        }
    }
    
    // 3. 定义构建后操作
    post {
        // "success" 表示只有在流水线所有阶段都成功后才执行
        success {
            echo 'Archiving the artifact...'
            // 使用 archiveArtifacts 步骤来归档构建产物
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
        }
    }
}
