<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: QZQ
  Date: 2018-07-07
  Time: 1:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head lang="en">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/flat-ui.min.css"/>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/flat-ui.min.js"></script>
    <title>登陆页</title>
    <style>
        .row{
            margin-left: 20px;
            margin-right: 20px;;
        }
    </style>
</head>
<body>
<!-- Static navbar -->
<div class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            </button>
            <a class="navbar-brand" href="index.jsp">图书商城</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="index.jsp">首页</a></li>
                <li><a href="order.jsp">我的订单</a></li>
                <li><a href="userInfo.jsp">个人中心</a></li>
                <li><a href="friendLink.jsp">好书荐购</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right hidden-sm">
                <%
                    if(session.getAttribute("username")==null){
                        out.println("<li><a href='login.jsp'>登录</a></li>");
                        out.println("<li><a href='register.jsp'>注册</a></li>");
                    }else{
                        out.println("<li><a href='userInfo.jsp'>"+session.getAttribute("username").toString()+" 欢迎您</a></li>");
                        out.println("<li><a href='logout.jsp'>退出</a></li>");
                    }
                %>
                <li><a href="cart.jsp"><span class="glyphicon glyphicon-shopping-cart">购物车</span></a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>
<!--content-->
<%
    // 从request中获取值
    request.setCharacterEncoding("utf-8");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String hashPassword = secure.MD5.encodeByMD5(password);
%>

<%
    String sql = "select password from user where uid=?";
    Connection con = db.DBCPUtils.getConnection();
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1,username);
    ResultSet resultSet = pstmt.executeQuery();
%>



<div class="container">
    <div class="row thumbnail center">


        <div class="col-sm-12">
            <%
                if(resultSet.next()){
                    if(hashPassword.equals(resultSet.getString(1))){
                        // pwd is right
                        // 添加登陆信息至session
                        session.setAttribute("username",username);

                        out.println("<div class='alert alert-warning' role='alert'>" +
                                "<h1 class='text-center' style='margin-bottom: 30px'>登陆成功</h1>" +
                                "<h3 class='text-center'>5秒后自动跳转...</h3></div>");
                        response.setHeader("refresh","5;url=index.jsp");
                    }else{
                        //pwd is wrong
                        session.removeAttribute("username");

                        out.println("<div class='alert alert-warning' role='alert'>" +
                                "<h1 class='text-center' style='margin-bottom: 30px'>密码错误</h1>" +
                                "<h3 class='text-center'>5秒后自动跳转...</h3></div>");
                        response.setHeader("refresh","5;url=login.jsp");
                    }
                }else{
                    // username not exist
                    session.removeAttribute("username");

                    out.println("<div class='alert alert-warning' role='alert'>" +
                            "<h1 class='text-center' style='margin-bottom: 30px'>用户名不存在</h1>" +
                            "<h3 class='text-center'>5秒后自动跳转...</h3></div>");
                    response.setHeader("refresh","5;url=login.jsp");
                }
            %>
        </div>


    </div>
</div>


<!--footer-->
<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
    This Website was developed by QiZQ & MengW & YangXD
</div>
<%
    db.DBCPUtils.closeAll(resultSet,pstmt,con);
%>
</body>
</html>
