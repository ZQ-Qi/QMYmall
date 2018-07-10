<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: QZQ
  Date: 2018-07-07
  Time: 9:16
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
        .line-center{
            line-height:50px;
            text-align: center;
        }
        /*.row input{*/
            /*width: 50px;*/
        /*}*/
        .list-group-item:hover{
            background: #27ae60;

        }
        .list-group-item div:first-child:hover{

            cursor: pointer;
        }
        th{
            text-align: right;
            width: 10%;;
            padding: 10px;
        }
        td{
            text-align: left;
            width: 30%;;
            padding: 10px;
        }
        .table th{
            text-align: center;
        }
        .table td{
            text-align: center;
        }
    </style>
    <script>
        function myClick(n){
            location.href = "OrderInfo.html";
        }
        function btnClick(){
            alert("btn");
            return false;
        }
        $(function(){

        })
    </script>
    <script>
        $(function(){
            $('#myTabs a').click(function (e) {
                $(this).tab('show')
            });
        })
    </script>
</head>
<body>
<%
    // 页面初始化
    request.setCharacterEncoding("utf-8");
    // 定义变量
    String username = "N/A";
    String _sex = "N/A";
    String telephone = "N/A";
    String address = "N/A";
    String email = "N/A";
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql;

    // 获取用户信息 若无用户信息则跳转登录界面
    if(session.getAttribute("username") == null){
        response.sendRedirect("login.jsp?err=2");
    }else{
        username = session.getAttribute("username").toString();
    }




    // 建立数据库连接,获取用户信息
    try{
        sql = "select * from user where uid = ?";
        con = db.DBCPUtils.getConnection();
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1,username);
        rs = pstmt.executeQuery();
        //pstmt.close();
        if(rs.next()){
            _sex = rs.getString("sex");
            telephone = rs.getString("telephone");
            address = rs.getString("address");
            email = rs.getString("email");
        }else{
            response.sendRedirect("login.jsp?err=2");
        }
    }catch (Exception e){
        out.println("<script>alert('数据库连接出现问题，请联系管理员');</script>");
    }

    // 数据库存储的sex为smallint，对其转换
    String sex;
    if("1".equals(_sex)){
        sex = "女";
    }else{
        sex = "男";
    }


%>
<!-- Static navbar -->
<div class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">这什么东西</span>
            </button>
            <a class="navbar-brand" href="index.jsp">图书商城</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="index.jsp">首页</a></li>
                <li><a href="order.jsp">我的订单</a></li>
                <li class="active"><a href="userInfo.jsp">个人中心</a></li>
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
    <div class="row thumbnail center col-sm-12">

        <div class="col-sm-12">
            <h1 class="text-center" style="margin-bottom: 30px">个人中心</h1>
        </div>

        <ul class="nav nav-tabs nav-justified" id="myTabs">
            <li class="active"><a href="#userHome" >个人中心</a></li>
            <li><a href="#editInfo">信息修改</a></li>
            <li><a href="#editPassword">密码修改</a></li>
            <%--<li><a href="#orderManager">订单管理</a></li>--%>
        </ul>
        <!-- Tab panes -->
        <div class="tab-content">

            <div role="tabpanel" class="tab-pane active" id="userHome">
                <br>
                <%
                    // 个人中心 输出个人信息
                    out.println("<ul class='list-group'>");
                    out.println("<li class='list-group-item'>用户名：" + username + "</li>");
                    out.println("<li class='list-group-item'>性别：" + sex + "</li>");
                    out.println("<li class='list-group-item'>电话：" + telephone + "</li>");
                    out.println("<li class='list-group-item'>地址：" + address + "</li>");
                    out.println("<li class='list-group-item'>邮箱：" + email + "</li>");
                    out.println("</ul>");
                %>
            </div>
            <div role="tabpanel" class="tab-pane" id="editInfo">
                <%--信息修改页--%>
                <%--提交信息后，传值回本页面继续进行处理--%>
                <div class="col-sm-12">
                    <form class="form-horizontal caption" id="inputForm" data-toggle="validator" action="" method="post">
                        <div class="form-group">
                            <label for="inlineRadio1" class="col-sm-3 control-label">性别</label>
                            <div class="col-sm-6">
                                <label class="radio-inline">
                                    <input type="radio" name="sex" id="inlineRadio1" value="0" required <%= ("男".equals(sex))?"checked":"" %>>男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="sex" id="inlineRadio2" value="1" required <%= ("女".equals(sex))?"checked":"" %>>女
                                </label>
                            </div>

                        </div>
                        <div class="form-group">
                            <label for="telephone" class="col-sm-3 control-label">电话</label>
                            <div class="col-sm-6">
                                <input type="tel" class="form-control" id="telephone" name="telephone"
                                       placeholder="电话号码"  pattern="^[1][0-9]{10}$"
                                       value="<%=telephone%>" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="address" class="col-sm-3 control-label">地址</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="address" name="address"
                                       placeholder="地址"
                                       value="<%=address%>" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email" class="col-sm-3 control-label">邮箱</label>
                            <div class="col-sm-6">
                                <input type="email" class="form-control" id="email" name="email"
                                       placeholder="邮箱"
                                       value="<%=email%>" required>
                            </div>
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-6">
                                <button type="submit" class="btn btn-success btn-block">修改</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
<%--判断是否进行了信息提交操作，并将提交操作操作的值更新数据库，并返回更新结果--%>
<%  // 判断是否进行了信息提交操作，并将提交操作操作的值更新数据库，并返回更新结果
    if(request.getParameter("sex") != null){
        try{
            String nSex = request.getParameter("sex");
            String nTelephone = request.getParameter("telephone");
            String nAddress = request.getParameter("address");
            String nEmail = request.getParameter("email");
            sql = "update user set sex = ?, telephone = ?, address = ?, email = ? where uid = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1,nSex);
            pstmt.setString(2,nTelephone);
            pstmt.setString(3,nAddress);
            pstmt.setString(4,nEmail);
            pstmt.setString(5,username);
            int res = pstmt.executeUpdate();
            if(res == 1){
                out.println("<script>alert('信息更改成功！');</script>");
                response.sendRedirect("userInfo.jsp");
            }else{
                out.println("<script>alert('信息更改失败或无信息被更改！');</script>");
            }
        }catch (Exception e){
            out.println("<script>alert('系统出错，更改未完成');</script>");
        }
    }
%>
            <div role="tabpanel" class="tab-pane" id="editPassword">
                密码修改
                <div class="col-sm-12">
                    <form class="form-horizontal caption" id="inputForm2" data-toggle="validator" action="" method="post">
                        <div class="form-group">
                            <label for="password0" class="col-sm-3 control-label">原密码</label>
                            <div class="col-sm-6">
                                <input type="password" class="form-control" id="password0" name="password0"
                                       placeholder="原密码" data-minlength="6"
                                       required>
                            </div>
                            <div class="help-block with-errors"></div>
                        </div>

                        <div class="form-group">
                        <label for="password1" class="col-sm-3 control-label">密码</label>
                        <div class="col-sm-6">
                        <input type="password" class="form-control" id="password1" name="password1"
                        placeholder="新密码" data-minlength="6"
                        data-error="至少6个字符！" required>
                        </div>
                        <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group">
                        <label for="password2" class="col-sm-3 control-label">确认密码</label>
                        <div class="col-sm-6">
                        <input type="password" class="form-control" id="password2" name="password2"
                        placeholder="确认密码"
                        data-match="#password1" data-match-error="两次输入的密码不匹配！" required>
                        </div>
                        <div class="help-block with-errors"></div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-6">
                                <button type="submit" class="btn btn-success btn-block">修改密码</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
<%--进行更改密码操作，对原密码进行校验，并更新新密码到数据库--%>
<%
    if(request.getParameter("password0") != null){
        String password0 = request.getParameter("password0");
        String password1 = request.getParameter("password1");
        String enPassword0 = secure.MD5.encodeByMD5(password0);
        String enPassword1 = secure.MD5.encodeByMD5(password1);
        try{
            // 对原密码进行校验
            sql = "select password from user where uid = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1,username);
            rs = pstmt.executeQuery();
            if(rs.next()){
                if(rs.getString("password").equals(enPassword0)){
                    // 原密码正确
                    sql = "update user set password = ? where uid = ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1,enPassword1);
                    pstmt.setString(2,username);
                    int res = pstmt.executeUpdate();
                    if(res == 1){
                        out.println("<script>alert('密码修改成功');</script>");
                    }else{
                        out.println("<script>alert('密码修改失败');</script>");
                    }
                }else {
                    // 原密码错误
                    out.println("<script>alert('原密码错误！');</script>");
                }
            }
        }catch (Exception e){
            out.println("<script>alert('系统错误，无法执行更改密码操作！');</script>");
            e.printStackTrace();
        }
    }
%>

            <%--<div role="tabpanel" class="tab-pane" id="orderManager">订单管理</div>--%>
        </div>
    </div>
</div>

<!--footer-->
<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
    This Website was developed by QiZQ & MengW & YangXD
</div>
<%
    // 关闭数据库
    db.DBCPUtils.closeAll(rs,pstmt,con);
%>
</body>
</html>
