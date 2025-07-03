pipeline {
    agent any

    tools {
        maven 'maven-3.8.6'
    }

    stages {
        // ... Compile 和 Test 阶段保持不变 ...
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
                // 我们运行 "clean package" 来确保每次都是全新的构建
                sh 'mvn clean package'
            }
        }

        // --- 新增的阶段 ---
        stage('Build Docker Image') {
            steps {
                echo "Building the Docker image..."
                // 使用 sh 命令调用 docker build
                // -t my-java-app:${env.BUILD_NUMBER} 给镜像打上标签，名字叫 my-java-app，版本号是 Jenkins 的构建号
                // . 表示使用当前目录的 Dockerfile
                sh 'docker build -t my-java-app:${env.BUILD_NUMBER} .'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "Running the Docker container..."
                // 先停止并删除同名的旧容器（如果有的话），防止端口冲突
                sh 'docker stop my-app-instance || true'
                sh 'docker rm my-app-instance || true'
                
                // 运行新镜像
                // -d 后台运行
                // -p 8090:8080 将主机的 8090 端口映射到容器的 8080 端口（Java应用通常的端口，虽然我们没用到）
                // --name 给容器起个实例名
                // my-java-app:${env.BUILD_NUMBER} 指定要运行哪个镜像
                sh 'docker run -d -p 8090:8080 --name my-app-instance my-java-app:${env.BUILD_NUMBER}'
            }
        }
    }
}
