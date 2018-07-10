<%--
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
    <script src="js/validator.js"></script>
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
                        out.println("<li class='active'><a href='login.jsp'>登录</a></li>");
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
<div class="container">
    <div class="row thumbnail center">
        <div class="col-sm-12">
            <h1 class="text-center" style="margin-bottom: 30px">用户登录</h1>
        </div>
        <div class="col-sm-12">
            <form class="form-horizontal caption" data-toggle="validator" action="login.jsp" method="post">
            <%--<form class="form-horizontal caption" data-toggle="validator" action="login_res.jsp" method="post">--%>
                <div class="form-group">
                    <label for="username" class="col-sm-3 control-label">用户名</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="username" name="username" placeholder="用户名" required>
                    </div>
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-sm-3 control-label">密码</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" id="password" name="password" placeholder="密码" required>
                    </div>
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <label for="checkcode" class="col-sm-3 control-label">验证码</label>
                    <div class="col-sm-6">
                        <img src="/YZM" onclick="reload()" id="checkimg" style="width:40%; ">
                        <input type="password" class="form-control" id="checkcode" name="checkcode" placeholder="验证码" required>

                    </div>
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-6">
                        <button type="submit" class="btn btn-success btn-block">登录</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<%
    request.setCharacterEncoding("utf-8");
    if(request.getParameter("checkcode") != null){
        if(request.getParameter("checkcode").toUpperCase().equals(session.getAttribute("codeValidate"))){
            request.getRequestDispatcher("login_res.jsp").forward(request,response);
        }else{
            response.sendRedirect("login.jsp?err=4");
        }
    }
%>

<!--footer-->
<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
    This Website was developed by QiZQ & MengW & YangXD
</div>
<script>
    function reload(){
        // document.getElementById("image").src="/imageServlet?date="+new Date().getTime();
        document.getElementById("checkimg").src="/YZM?date="+new Date().getTime();
        $("#checkcode").val("");   // 将验证码清空
    }
</script>
<%
    // 错误码为2，则为未登陆就进行操作
    String err = request.getParameter("err");
    if("2".equals(err)){
        out.println("<script>alert('请先登录再进行操作');</script>");
    }else if("4".equals(err)){
        out.println("<script>alert('验证码错误');</script>");
    }
%>
</body>
</html>
