# 在线考试管理系统（SSM）

## How to Run

### 方式一：Docker 一键启动（推荐）

```bash
# 克隆项目后，在项目根目录执行：
docker-compose up --build -d

# 查看日志
docker-compose logs -f

# 停止服务
docker-compose down

# 停止并清除数据卷（重置数据库）
docker-compose down -v
```

启动完成后访问：http://localhost:8080

### 方式二：本地环境搭建

#### 1. 安装 JDK 17

- 下载地址：https://adoptium.net/temurin/releases/?version=17
- 安装后配置环境变量：
  - `JAVA_HOME`：JDK 安装目录（如 `C:\Program Files\Eclipse Adoptium\jdk-17`）
  - `Path`：追加 `%JAVA_HOME%\bin`
- 验证：`java -version`，输出应包含 `openjdk version "17.x.x"`

#### 2. 安装 Maven 3.8

- 下载地址：https://maven.apache.org/download.cgi
- 解压到指定目录，配置环境变量：
  - `MAVEN_HOME`：Maven 解压目录
  - `Path`：追加 `%MAVEN_HOME%\bin`
- 配置 `settings.xml`（位于 `conf/settings.xml`）：
  - 设置本地仓库路径：`<localRepository>D:/maven-repo</localRepository>`
  - 添加阿里云镜像加速：
    ```xml
    <mirror>
        <id>aliyun</id>
        <mirrorOf>central</mirrorOf>
        <url>https://maven.aliyun.com/repository/central</url>
    </mirror>
    ```
- 验证：`mvn -v`，输出应包含 `Apache Maven 3.8.x`

#### 3. 安装 Tomcat 8.5

- 下载地址：https://tomcat.apache.org/download-85.cgi
- 解压到指定目录，默认端口 8080
- 验证：运行 `bin/catalina.sh run`（Linux/Mac）或 `bin\catalina.bat run`（Windows），浏览器访问 `http://localhost:8080` 看到 Tomcat 欢迎页

#### 4. 安装 MySQL 8.0

- 下载地址：https://dev.mysql.com/downloads/mysql/
- 安装后创建数据库并导入初始数据：
  ```bash
  mysql -u root -p < backend/sql/exam_system.sql
  ```
- 修改 `backend/src/main/resources/db.properties` 中的数据库连接信息（host 改为 `localhost`，密码改为你的 MySQL 密码）

#### 5. 安装 IntelliJ IDEA

- 下载地址：https://www.jetbrains.com/idea/download/
- 打开项目：File → Open → 选择 `backend` 目录
- 配置 Tomcat：Run → Edit Configurations → 添加 Tomcat Server → 配置 Deployment 为 `exam-system:war exploded`
- 运行项目，访问 `http://localhost:8080`

#### 6. 运行测试

```bash
cd backend
mvn test
```

## Services

| 服务 | 端口 | 说明 |
|------|------|------|
| backend | 8080 | 后端应用（Tomcat 8.5 + SSM） |
| mysql | 3308 | MySQL 8.0 数据库 |

## 测试账号

> 密码在数据库中以 MD5 加密存储，登录时输入下表中的明文密码即可。

| 角色 | 用户名 | 密码 | 真实姓名 | 权限 |
|------|--------|------|----------|------|
| 管理员 | admin | admin123 | 系统管理员 | 用户管理、考试管理、题库管理 |
| 教师 | teacher | teacher123 | 张老师 | 考试管理、题库管理 |
| 教师 | teacher2 | teacher123 | 李老师 | 考试管理、题库管理 |
| 学生 | student | student123 | 王小明 | 参加考试、查看成绩 |
| 学生 | student2 | student123 | 赵小红 | 参加考试、查看成绩 |
| 学生 | student3 | student123 | 刘小强 | 参加考试、查看成绩 |

## 题目内容

SSM 开发环境搭建实训要求总结

一、环境配置要求

软件版本需符合指定标准，需安装 JDK 17、Maven 3.8、Tomcat 8.5、MySQL 8.0 及 IntelliJ IDEA，硬件需为 i5 及以上处理器、8GB 内存的 Windows/Linux 系统计算机。

环境变量配置准确，JDK 需配置 JAVA_HOME 与 Path 变量，Maven 需配置 settings.xml 文件（含阿里云镜像加速、本地仓库路径设置），Tomcat 默认配置 8080 端口。

需通过命令行验证服务状态，使用 java -version （JDK）、 mvn -v （Maven）、 catalina run （Tomcat）命令检测，确保版本匹配且服务启动正常。

二、项目创建要求

项目类型为 Java Web 项目（Dynamic Web Project），目录结构需遵循 Maven 规范，包含 src/main/java、src/main/resources、web/WEB-INF 等核心目录。

Maven 依赖配置正确，需在 pom.xml 中添加 spring-context、spring-webmvc、mybatis、mybatis-spring 等核心依赖包，确保无依赖冲突，项目可正常编译。

三、配置文件要求

三大框架核心配置文件需完整，包括 Spring 的 applicationContext.xml（配置 IOC 容器、组件扫描、事务管理）、Spring MVC 的 spring-mvc.xml（配置 DispatcherServlet、视图解析器、静态资源映射）、MyBatis 的 mybatis-config.xml（配置数据源、SQL 映射文件扫描、别名），以及 web.xml（注册 DispatcherServlet、设置 Spring 监听器）。

配置文件关键节点无误，组件扫描路径、数据源信息等核心配置准确，注释清晰，启动 Tomcat 时无报错。

四、考核相关要求

需满足考核评分标准，涵盖环境配置正确性（40 分）、项目创建完整性（30 分）、配置文件规范性（20 分），最终达到无编译错误、服务启动正常、配置合理规范的要求。

---

## 项目介绍

基于 Spring + Spring MVC + MyBatis（SSM）框架的在线考试管理系统，使用 JSP 作为视图层，MySQL 8.0 存储数据，Tomcat 8.5 部署运行。

### 技术栈

- Java 17 + Spring 5.3 + Spring MVC + MyBatis 3.5
- Hibernate Validator 6.2（Bean Validation 输入校验）
- SLF4J + Log4j2（日志框架）
- MySQL 8.0 + Druid 连接池
- Tomcat 8.5 + JSP + JSTL
- JUnit 4 + Mockito 5（单元测试）
- Maven 3.8 构建
- Docker + Docker Compose 容器化部署

### 功能模块

- 用户模块：登录、注册、用户管理（管理员/教师/学生三种角色）
- 考试模块：考试列表、创建考试、在线答题、自动判分
- 题库模块：题目增删改查（单选/多选/判断/填空/简答）
- 成绩模块：考试记录查询
- 安全模块：登录拦截器、输入校验、全局异常处理

### 项目结构

```
├── backend/                        # 后端项目（SSM + JSP）
│   ├── Dockerfile
│   ├── pom.xml
│   ├── sql/                        # 数据库初始化脚本
│   └── src/
│       ├── main/java/com/exam/
│       │   ├── controller/         # 控制器层（含全局异常处理）
│       │   ├── interceptor/        # 拦截器（登录校验）
│       │   ├── service/            # 业务逻辑层
│       │   ├── mapper/             # MyBatis Mapper 接口
│       │   └── entity/             # 实体类（含 Validation 注解）
│       ├── main/resources/         # 配置文件（Spring/MyBatis/Log4j2）
│       ├── main/webapp/            # Web 资源（JSP、CSS、JS）
│       └── test/java/com/exam/     # 单元测试
├── docker-compose.yml
├── .gitignore
└── README.md
```
