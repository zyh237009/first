# 1. 基础镜像：指定我们的应用需要运行在什么样的环境里
# 我们选择一个包含 Java 11 (JDK) 的官方镜像
FROM openjdk:11-jdk

# 2. 定义一个构建参数，用于接收 .jar 文件的路径
ARG JAR_FILE=target/*.jar

# 3. 将构建好的 .jar 文件复制到镜像中，并重命名为 app.jar
COPY ${JAR_FILE} /app.jar

# 4. 容器启动时要执行的命令
# 使用 "java -jar" 来运行我们的应用程序
ENTRYPOINT ["java","-jar","/app.jar"]
