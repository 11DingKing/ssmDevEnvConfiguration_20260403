-- 考试系统数据库脚本
-- 适用于 MySQL 8.0

CREATE DATABASE IF NOT EXISTS exam_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE exam_system;

-- 用户表
DROP TABLE IF EXISTS `exam_record`;
DROP TABLE IF EXISTS `exam_question`;
DROP TABLE IF EXISTS `exam`;
DROP TABLE IF EXISTS `question`;
DROP TABLE IF EXISTS `subject`;
DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    `password` VARCHAR(100) NOT NULL COMMENT '密码',
    `real_name` VARCHAR(50) COMMENT '真实姓名',
    `role` INT DEFAULT 2 COMMENT '角色：0-管理员 1-教师 2-学生',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

CREATE TABLE `subject` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `subject_name` VARCHAR(100) NOT NULL COMMENT '科目名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='科目表';

CREATE TABLE `question` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `subject_id` INT COMMENT '所属科目ID',
    `type` INT NOT NULL COMMENT '题型：1-单选 2-多选 3-判断 4-填空 5-简答',
    `content` TEXT NOT NULL COMMENT '题目内容',
    `option_a` VARCHAR(500) COMMENT '选项A',
    `option_b` VARCHAR(500) COMMENT '选项B',
    `option_c` VARCHAR(500) COMMENT '选项C',
    `option_d` VARCHAR(500) COMMENT '选项D',
    `answer` VARCHAR(500) NOT NULL COMMENT '正确答案',
    `score` INT DEFAULT 5 COMMENT '分值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='题目表';

CREATE TABLE `exam` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `exam_name` VARCHAR(200) NOT NULL COMMENT '考试名称',
    `subject_id` INT COMMENT '科目ID',
    `start_time` DATETIME COMMENT '开始时间',
    `end_time` DATETIME COMMENT '结束时间',
    `duration` INT COMMENT '考试时长(分钟)',
    `total_score` INT COMMENT '总分',
    `creator_id` INT COMMENT '创建人ID',
    `status` INT DEFAULT 0 COMMENT '状态：0-未开始 1-进行中 2-已结束'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='考试表';

CREATE TABLE `exam_question` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `exam_id` INT NOT NULL,
    `question_id` INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='考试题目关联表';

CREATE TABLE `exam_record` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `exam_id` INT NOT NULL COMMENT '考试ID',
    `student_id` INT NOT NULL COMMENT '学生ID',
    `score` INT COMMENT '得分',
    `submit_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='考试记录表';

-- ========== 用户数据 ==========
INSERT INTO `user`(username, password, real_name, role) VALUES('admin', '0192023a7bbd73250516f069df18b500', '系统管理员', 0);
INSERT INTO `user`(username, password, real_name, role) VALUES('teacher', 'a426dcf72ba25d046591f81a5495eab7', '张老师', 1);
INSERT INTO `user`(username, password, real_name, role) VALUES('teacher2', 'a426dcf72ba25d046591f81a5495eab7', '李老师', 1);
INSERT INTO `user`(username, password, real_name, role) VALUES('student', 'ad6a280417a0f533d8b670c61667e1a0', '王小明', 2);
INSERT INTO `user`(username, password, real_name, role) VALUES('student2', 'ad6a280417a0f533d8b670c61667e1a0', '赵小红', 2);
INSERT INTO `user`(username, password, real_name, role) VALUES('student3', 'ad6a280417a0f533d8b670c61667e1a0', '刘小强', 2);

-- ========== 科目数据 ==========
INSERT INTO `subject`(subject_name) VALUES('Java程序设计');
INSERT INTO `subject`(subject_name) VALUES('数据库原理');
INSERT INTO `subject`(subject_name) VALUES('计算机网络');
INSERT INTO `subject`(subject_name) VALUES('操作系统');

-- ========== Java程序设计 题目（科目ID=1） ==========
-- 单选题
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(1, 1, 'Java中用于定义类的关键字是？', 'class', 'struct', 'define', 'type', 'A', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(1, 1, 'String类位于以下哪个包中？', 'java.util', 'java.lang', 'java.io', 'java.net', 'B', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(1, 1, '以下哪个不是Java的基本数据类型？', 'int', 'float', 'String', 'boolean', 'C', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(1, 1, 'Java中用于实现接口的关键字是？', 'extends', 'implements', 'interface', 'abstract', 'B', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(1, 1, '以下哪个集合类是线程安全的？', 'ArrayList', 'HashMap', 'Vector', 'LinkedList', 'C', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(1, 1, 'JVM中负责加载类文件的是？', '执行引擎', '类加载器', '垃圾回收器', '即时编译器', 'B', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(1, 1, 'Java异常处理中，用于捕获异常的关键字是？', 'throw', 'throws', 'catch', 'finally', 'C', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(1, 1, '以下哪个修饰符表示该成员只能在本类中访问？', 'public', 'protected', 'default', 'private', 'D', 5);
-- 判断题
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(1, 3, 'Java支持多重继承（一个类可以继承多个父类）', NULL, NULL, NULL, NULL, 'F', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(1, 3, 'Java中的接口可以包含默认方法（default method）', NULL, NULL, NULL, NULL, 'T', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(1, 3, 'final修饰的变量值可以被修改', NULL, NULL, NULL, NULL, 'F', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(1, 3, 'Java中所有类都直接或间接继承自Object类', NULL, NULL, NULL, NULL, 'T', 5);

-- ========== 数据库原理 题目（科目ID=2） ==========
-- 单选题
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(2, 1, 'SQL中用于查询数据的关键字是？', 'UPDATE', 'SELECT', 'INSERT', 'DELETE', 'B', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(2, 1, '以下哪个是数据库的第三范式（3NF）要求？', '消除非主属性对主键的部分依赖', '消除非主属性对主键的传递依赖', '消除主属性对候选键的部分依赖', '消除多值依赖', 'B', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(2, 1, '事务的ACID特性中，A代表什么？', '原子性', '一致性', '隔离性', '持久性', 'A', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(2, 1, '以下哪种索引结构在MySQL InnoDB中最常用？', '哈希索引', 'B+树索引', '全文索引', '位图索引', 'B', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(2, 1, 'SQL中用于删除表结构的语句是？', 'DELETE TABLE', 'DROP TABLE', 'REMOVE TABLE', 'TRUNCATE TABLE', 'B', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(2, 1, '以下哪个不属于数据库的完整性约束？', '实体完整性', '参照完整性', '用户自定义完整性', '并发完整性', 'D', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(2, 1, 'MySQL中用于查看表结构的命令是？', 'SHOW TABLE', 'DESC', 'VIEW TABLE', 'LIST COLUMNS', 'B', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(2, 1, '关系代数中，从表中选取满足条件的行的操作叫？', '投影', '选择', '连接', '除法', 'B', 5);
-- 判断题
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(2, 3, '视图是数据库中实际存储数据的表', NULL, NULL, NULL, NULL, 'F', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(2, 3, '主键字段的值不允许为NULL', NULL, NULL, NULL, NULL, 'T', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(2, 3, '外键约束可以保证参照完整性', NULL, NULL, NULL, NULL, 'T', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(2, 3, 'TRUNCATE语句可以回滚', NULL, NULL, NULL, NULL, 'F', 5);

-- ========== 计算机网络 题目（科目ID=3） ==========
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(3, 1, 'OSI参考模型共有几层？', '4层', '5层', '6层', '7层', 'D', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(3, 1, 'HTTP协议默认使用的端口号是？', '21', '22', '80', '443', 'C', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(3, 1, 'TCP协议属于OSI模型的哪一层？', '网络层', '传输层', '会话层', '应用层', 'B', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(3, 1, 'IP地址192.168.1.1属于哪类地址？', 'A类', 'B类', 'C类', 'D类', 'C', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(3, 1, '以下哪个协议用于域名解析？', 'FTP', 'DNS', 'SMTP', 'DHCP', 'B', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(3, 1, 'TCP三次握手中，第二次握手发送的标志位是？', 'SYN', 'ACK', 'SYN+ACK', 'FIN', 'C', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(3, 3, 'UDP协议是面向连接的可靠传输协议', NULL, NULL, NULL, NULL, 'F', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(3, 3, 'ARP协议的作用是将IP地址解析为MAC地址', NULL, NULL, NULL, NULL, 'T', 5);

-- ========== 操作系统 题目（科目ID=4） ==========
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(4, 1, '进程和线程的主要区别是？', '进程有独立地址空间，线程共享进程地址空间', '线程有独立地址空间', '进程比线程更轻量', '两者没有区别', 'A', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(4, 1, '以下哪种调度算法可能导致饥饿现象？', '先来先服务', '短作业优先', '时间片轮转', '多级反馈队列', 'B', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(4, 1, '虚拟内存使用的页面置换算法中，理论最优的是？', 'FIFO', 'LRU', 'OPT', 'CLOCK', 'C', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(4, 1, '产生死锁的四个必要条件不包括？', '互斥条件', '请求与保持', '抢占条件', '循环等待', 'C', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(4, 3, '多道程序设计可以提高CPU利用率', NULL, NULL, NULL, NULL, 'T', 5);
INSERT INTO `question`(subject_id, type, content, option_a, option_b, option_c, option_d, answer, score)
VALUES(4, 3, '用户态程序可以直接执行特权指令', NULL, NULL, NULL, NULL, 'F', 5);

-- ========== 考试数据 ==========
-- Java期中考试（10题，50分）
INSERT INTO `exam`(exam_name, subject_id, duration, total_score, creator_id, status)
VALUES('Java程序设计期中考试', 1, 60, 50, 2, 1);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(1, 1);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(1, 2);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(1, 3);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(1, 4);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(1, 5);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(1, 6);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(1, 7);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(1, 8);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(1, 9);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(1, 10);

-- 数据库原理期末考试（10题，50分）
INSERT INTO `exam`(exam_name, subject_id, duration, total_score, creator_id, status)
VALUES('数据库原理期末考试', 2, 90, 50, 2, 1);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(2, 13);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(2, 14);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(2, 15);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(2, 16);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(2, 17);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(2, 18);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(2, 19);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(2, 20);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(2, 21);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(2, 22);

-- 计算机网络测验（8题，40分）
INSERT INTO `exam`(exam_name, subject_id, duration, total_score, creator_id, status)
VALUES('计算机网络单元测验', 3, 45, 40, 3, 1);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(3, 25);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(3, 26);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(3, 27);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(3, 28);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(3, 29);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(3, 30);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(3, 31);
INSERT INTO `exam_question`(exam_id, question_id) VALUES(3, 32);
