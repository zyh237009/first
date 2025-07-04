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
            // 定义过滤器：仅当 push 事件发生在 main 分支时才触发
            filter: {
                // **【修正处】** 对美元符号 $ 进行转义，防止 Groovy 语法解析错误
                expression: '\$.ref',
                text: 'refs/heads/main'
            }
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

