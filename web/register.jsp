<%--
  Created by IntelliJ IDEA.
  User: QZQ
  Date: 2018-07-07
  Time: 9:18
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
    <title></title>
    <style>
        .row{
            margin-left: 20px;
            margin-right: 20px;;
        }
    </style>
    <%--使用Bootstrap样式并使用validator进行数据输入验证，各个input数据不能为空且校验email是否含@ 校验两次密码输入是否一致--%>
</head>
<body>
<!-- Static navbar -->
<div class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"></button>
            <a class="navbar-brand" href="index.jsp">图书商城</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="index.jsp">首页</a></li>
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
<div class="container">
    <div class="row thumbnail">
        <div class="col-sm-12">
            <h1 class="text-center" style="margin-bottom: 30px">用户注册</h1>
        </div>

        <div class="col-sm-12">
            <form class="form-horizontal caption" id="inputForm" data-toggle="validator" action="register_res.jsp" method="post">
                <div class="form-group">
                    <label for="username" class="col-sm-3 control-label">用户名</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="username" name="username"
                               placeholder="用户名" pattern="^[a-zA-Z]{1}[a-zA-Z0-9_]{2,15}$"
                        <%--
                        ^：匹配行首，即，从每行的开头开始匹配
                        [a-zA-Z]{1}：第一个字符要求是字母，即从a到z或者A到Z
                        [a-zA-Z0-9_]{2,15}：匹配长度为2到15的字母或数字，或下划线
                        $：匹配行尾--%>
                               data-error="用户名不规范！英文开头，3-16字符" required>
                    </div>
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-sm-3 control-label">密码</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" id="password" name="password"
                               placeholder="密码" data-minlength="6"
                               data-error="至少6个字符！" required>
                    </div>
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-sm-3 control-label">确认密码</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" id="password2" name="password2"
                               placeholder="确认密码"
                               data-match="#password" data-match-error="两次输入的密码不匹配！" required>
                    </div>
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <label for="inlineRadio1" class="col-sm-3 control-label">性别</label>
                    <div class="col-sm-6">
                        <label class="radio-inline">
                            <input type="radio" name="sex" id="inlineRadio1" value="0" required>男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="sex" id="inlineRadio2" value="1" required>女
                        </label>
                    </div>

                </div>
                <div class="form-group">
                    <label for="telephone" class="col-sm-3 control-label">电话</label>
                    <div class="col-sm-6">
                        <input type="tel" class="form-control" id="telephone" name="telephone"
                               placeholder="电话号码"  pattern="^[1][0-9]{10}$" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="address" class="col-sm-3 control-label">地址</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="address" name="address"
                               placeholder="地址" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="email" class="col-sm-3 control-label">邮箱</label>
                    <div class="col-sm-6">
                        <input type="email" class="form-control" id="email" name="email"
                               placeholder="邮箱" required>
                    </div>
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-6">
                        <button type="submit" class="btn btn-success btn-block">注册</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!--footer-->
<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
    This Website was developed by QiZQ & MengW & YangXD
</div>



<%
    // 若存在错误码1，则提示用户名已存在
    request.setCharacterEncoding("utf-8");
    String warning = request.getParameter("err");
    if("1".equals(warning)){
        out.println("<script> alert('用户名已存在');</script>");
    }else
%>



</body>
</html>
