<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: QZQ
  Date: 2018-07-07
  Time: 9:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--还需要添加--%>
<html>
<head lang="en">
    <meta charset="UTF-8">

    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/flat-ui.min.css"/>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/flat-ui.min.js"></script>
    <title>图书详情</title>
    <style>
        .row{
            margin-left: 20px;
            margin-right: 20px;;
        }
        .center{
            text-align: center;
        }
        .caption p{
            font-size:1.5em;
        }
        img{
            width: 100%;
            display: block;
        }
    </style>
</head>
<body>
<%
    //获取request传值
    request.setCharacterEncoding("utf-8");
    String bookid = request.getParameter("bookid");
    if(bookid == null){
        bookid = "1001"; // 若获取传值失败，则使用1001号图书
    }
    //定义要获取的值对象
    String bookname = "N/A";
    String author = "N/A";
    String pubdate = "N/A";
    String category="N/A";
    String introduction="未查询到此书相关信息，请联系管理员解决";
    String price="N/A";
    String picpath="img/book/0000.jpg";

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    //连接数据库，获取图书详情
    try{
        String sql = "select * from book where bookid = ?";
        con = db.DBCPUtils.getConnection();
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1,bookid);
        rs = pstmt.executeQuery();
        if(rs.next()){
            bookname = rs.getString("bookname");
            author = rs.getString("author");
            pubdate = rs.getString("pubdate");
            category = rs.getString("category");
            introduction = rs.getString("introduction");
            price = rs.getString("price");
            picpath = rs.getString("picpath");
        }else{

        }
    }catch (Exception e){
        e.printStackTrace();
    }

%>
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
                <li>
                    <a href="cart.jsp"><span class="glyphicon glyphicon-shopping-cart">购物车</span></a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>

<!--content-->
<div class="row thumbnail">
    <div class="col-sm-4">
        <img src="<%=picpath%>"  data-holder-rendered="true">
        <div class="caption center">
            <h3><%=bookname%></h3>
            <table class="table table-striped">
                <tr><th class="text-center">单价</th><th class="text-center"><%=price%></th></tr>
                <tr class="text-center"><td>分类</td><td><%=category%></td></tr>
                <tr class="text-center"><td>作者</td><td><%=author%></td></tr>
                <tr class="text-center"><td>出版时间</td><td><%=pubdate%></td></tr>
            </table>

            <p>
                <a class="btn btn-primary btn-block" role="button" href="orderInfo.jsp?action=<%=bookid%>">立即购买</a>
                <a class="btn btn-default btn-block" role="button" href="cart.jsp?addcart=<%=bookid%>">加入购物车</a></p>
        </div>
    </div>
    <div class="col-sm-8">
        <div class="caption">
            <h3>图书介绍</h3>
            <p><%=introduction%></p>
        </div>
    </div>

</div>
<!--footer-->
<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
    This Website was developed by QiZQ & MengW & YangXD
</div>
<%
    db.DBCPUtils.closeAll(rs,pstmt,con);
%>
</body>
</html>
