#  QMY图书商城配置文档

### 作者： 亓志强

## 配置数据库

- 本站点采用Mysql作为数据库
- 使用JDBC与数据库建立连接
- 采用DBCP技术建立数据库连接池
- 数据库连接属性在src / config / dbcpconfig.properties 中进行配置
- 默认配置方法
  - user: root
  - password: admin
  - port: 3306
  - database: qzqmall
  - useSSL: false
- 使用 sql / initialize.sql 对数据库进行建表和初始化

## 搭建环境

- JAVA：1.8.0_171
- TOMCAT： 9.0.8
- IDE： IntelliJ IDEA ULTIMATE 2018.1

## 包依赖

### JAR

#### 本工程所引用的JAR包主要用于建立数据库连接和构建数据库连接池

- commons-collections4-4.1.jar
- commons-dbcp2-2.4.0
- commons-loggin-1.2.jar
- commons-pool2-2.5.0.jar
- mysql-connector-java-5.1.396-bin.jar

此外还包括TOMCAT及JDK附带 lib 下的JAR包

### CSS

#### 本工程所采用的CSS样式表主要有Bootstrap样式及Flat-UI两个样式，其余为内置样式

- bootstrap.min.css
- flat-ui.min.css

### JavaScript

#### 本工程共使用了jQuery & Bootstrap & flat-ui 三个JS文档，部分需要进行表单校验的引入了一个jQuery插件Validator

- jquery.min.js
- bootstrap.min.js
- flat-ui.min.js
- validator.js

## 参考

#### 在构建本工程时主要参考了如下几个网页：

[JSP实现验证码](https://blog.csdn.net/Knove/article/details/77686504)

[使用JSP+Servlet实现图片验证码-](https://blog.csdn.net/weixian52034/article/details/52186207)

[数据库连接池 Java数据库连接池--DBCP浅析](https://www.cnblogs.com/wang-meng/p/5463020.html)

[JAVA 对字符串进行MD5加密](https://blog.csdn.net/github_38151745/article/details/71367151)

[简单实用的Bootstrap3表单验证插件](http://www.htmleaf.com/jQuery/Form/201601062989.html)

[利用JSP session对象保持住登录状态](https://www.jb51.net/article/114222.htm)

[JSP作业3 - 使用JSP实现简单的用户登录注册页面](https://blog.csdn.net/mayuko2012/article/details/72977784)