pipeline {
    agent any

    // 新增部分：定义流水线的触发器
    triggers {
        // 定义一个通用的 Webhook 触发器
        genericWebhookTrigger(
            // 1. 定义一个安全令牌 (token)，相当于一个接头暗号
            token: 'my-secret-token-123',

            // 2. 定义触发的原因，会显示在构建历史里
            causeMessage: 'Webhook triggered by Git push',

            // 3. 打印接收到的所有数据，方便调试 (生产环境可设为 false)
            printPostContent: true,
            printContributedVariables: true,

            // 4. 定义过滤器：只有满足条件的信号才能触发流水线
            filter: {
                // 检查请求中的 ref 字段是否是 "refs/heads/main" (即推送到 main 分支)
                expression: '$.ref',
                text: 'refs/heads/main'
            }
        )
    }

    tools {
        maven 'maven-3.8.6'
    }

    stages {
        // ... 这里的所有 stage 保持不变 ...
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
