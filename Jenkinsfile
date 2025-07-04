pipeline {
    agent any

    // 定义流水线的自动触发器
    triggers {
        genericWebhookTrigger(
            // 定义一个用于安全验证的令牌 (可自定义)
            token: 'my-secret-token-123',
            // 定义触发原因，会显示在构建历史中
            causeMessage: 'Webhook triggered by Git push',
            // 打印接收到的数据，方便调试
            printPostContent: true,

            // **【最终修正】** 使用插件的显式参数，彻底避免 Groovy 解析歧义
            // 过滤表达式，用于提取 JSON 请求中的 'ref' 字段
            filterExpression: '$.ref',
            // 过滤文本，只有当 'ref' 字段的值等于它时，才触发构建
            filterText: 'refs/heads/main'
        )
    }

    tools {
        maven 'maven-3.8.6'
    }

    stages {
        stage('Compile') {
            steps {
                echo 'Compiling the application...'
                sh 'mvn compile'
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'mvn test'
            }
        }
        stage('Package') {
            steps {
                echo 'Packaging the application...'
                sh 'mvn clean package'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo "Building the Docker image..."
                sh "docker build -t my-java-app:${env.BUILD_NUMBER} ."
            }
        }
        stage('Run Docker Container') {
            steps {
                echo "Running the Docker container..."
                sh "docker stop my-app-instance || true"
                sh "docker rm my-app-instance || true"
                sh "docker run -d -p 8090:8080 --name my-app-instance my-java-app:${env.BUILD_NUMBER}"
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished. Cleaning up workspace...'
            cleanWs()
        }
    }
}

