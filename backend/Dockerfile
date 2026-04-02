# ============ 阶段1: Maven 编译 ============
FROM maven:3.8-eclipse-temurin-17 AS builder

WORKDIR /build
COPY pom.xml .
# 先下载依赖（利用 Docker 缓存层）
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn package -DskipTests -B

# ============ 阶段2: Tomcat 运行 ============
FROM tomcat:8.5-jdk17-temurin

# 清除默认应用
RUN rm -rf /usr/local/tomcat/webapps/*

# 设置 Tomcat URI 编码为 UTF-8，解决中文乱码
RUN sed -i 's/Connector port="8080"/Connector port="8080" URIEncoding="UTF-8"/' /usr/local/tomcat/conf/server.xml

# 拷贝编译产物到 Tomcat webapps（ROOT.war 部署到根路径）
COPY --from=builder /build/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

ENV JAVA_OPTS="-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8"
CMD ["catalina.sh", "run"]
