/**
 * 最终版 Jenkinsfile
 * 功能：
 * 1. 使用 Maven 编译、测试、打包一个 Java 项目。
 * 2. 构建一个 Docker 镜像来包含打包好的 .jar 文件。
 * 3. 运行这个 Docker 镜像，模拟部署。
 *
 * 修正：
 * - 所有的 sh 命令都使用了双引号 "..." 来确保 Jenkins 环境变量能被正确替换。
 */
pipeline {
    // 1. 在任何可用的 agent 上运行
    agent any

    // 2. 声明流水线需要使用的工具 (在 Jenkins 全局工具中配置)
    tools {
        maven 'maven-3.8.6'
    }

    // 3. 定义流水线的各个阶段
    stages {
        // 编译阶段
        stage('Compile') {
            steps {
                echo 'Compiling the application...'
                sh 'mvn compile'
            }
        }

        // 测试阶段
        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'mvn test'
            }
        }

        // 打包阶段 (使用 clean package 确保每次都是全新构建)
        stage('Package') {
            steps {
                echo 'Packaging the application...'
                sh 'mvn clean package'
            }
        }

        // 构建 Docker 镜像阶段
        stage('Build Docker Image') {
            steps {
                echo "Building the Docker image..."
                // 使用双引号来正确替换 ${env.BUILD_NUMBER} 变量
                sh "docker build -t my-java-app:${env.BUILD_NUMBER} ."
            }
        }

        // 运行 Docker 容器阶段 (模拟部署)
        stage('Run Docker Container') {
            steps {
                echo "Running the Docker container..."
                // 先停止并删除可能存在的同名旧容器
                sh "docker stop my-app-instance || true"
                sh "docker rm my-app-instance || true"
                
                // 运行新构建的镜像
                // 使用双引号来正确替换 ${env.BUILD_NUMBER} 变量
                sh "docker run -d -p 8090:8080 --name my-app-instance my-java-app:${env.BUILD_NUMBER}"
            }
        }
    }

    // 4. 定义构建结束后的操作
    post {
        // 无论成功还是失败，总是在最后清理工作空间
        always {
            cleanWs()
        }
    }
}
