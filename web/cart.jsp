<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.DecimalFormat" %><%--
  Created by IntelliJ IDEA.
  User: QZQ
  Date: 2018-07-07
  Time: 9:06
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
        .row input{
            width: 50px;
        }
    </style>
</head>
<body>
<%--检验用户是否登录，未登录自动跳转到登录页--%>
<%
    // 页面初始化
    request.setCharacterEncoding("utf-8");
    // 定义变量
    String username = "N/A";
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql;
    int globalTotalBook = 0;
    double globalTotalPrice = 0;
    DecimalFormat df = new DecimalFormat("######0.00");
    // 获取用户信息 若无用户信息则跳转登录界面
    if(session.getAttribute("username") == null){
        response.sendRedirect("login.jsp?err=2");
    }else{
        username = session.getAttribute("username").toString();
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
                <li class="active">
                    <a href="cart.jsp"><span class="glyphicon glyphicon-shopping-cart">购物车</span></a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>
<!--content-->
<div class="container">
    <div class="row thumbnail center">
        <div class="col-sm-12">
            <h1 class="text-center" style="margin-bottom: 30px">购物车</h1>
        </div>
        <div class=" list-group">

            <div class="col-sm-12 thumbnail">
                <div class="col-sm-4 line-center">图书</div>
                <div class="col-sm-1 line-center">单价</div>
                <div class="col-sm-4 line-center">数量 </div>
                <div class="col-sm-2 line-center">小计</div>
                <div class="col-sm-1 line-center">操作</div>
            </div>
            <%
                // 连接数据库，获取订单信息
                try{
                    con = db.DBCPUtils.getConnection();
                    sql = "select book.bookid,bookname,price,number from book,cart where book.bookid = cart.bookid AND uid= ? ";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1,username);
                    rs = pstmt.executeQuery();
                    while(rs.next()){
                        int iNum = Integer.parseInt(rs.getString("number"));
                        double dPrice= Double.parseDouble(rs.getString("price"));
                        globalTotalBook += iNum;
                        globalTotalPrice += dPrice * iNum;
                        String totalprice = df.format(dPrice * iNum);
            %>
            <div class="col-sm-12  list-group-item">
                    <div class="col-sm-1 line-center" style="width: 50px;height: 50px;">
                        <img src="img/icons/png/Book.png" style="height: 100%;" alt=""/>
                    </div>
                    <div class="col-sm-3 line-center"><%=rs.getString("bookname")%></div>
                    <div class="col-sm-1 line-center"><%=rs.getString("price")%></div>
                    <div class="col-sm-4 line-center">

                            <button type="button" class="btn btn-default" name="up" onclick="javascript:location.href='cart.jsp?action=down&bookid=<%=rs.getString(1)%>&number=<%=rs.getString("number")%>'">
                                <%--add--%>
                                <span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
                            </button>
                        <input type="text" class="small" readonly value="<%=rs.getString("number")%>"/>
                            <button type="button" class="btn btn-default" name="down" onclick="javascript:location.href='cart.jsp?action=up&bookid=<%=rs.getString(1)%>&number=<%=rs.getString("number")%>'">
                                <%--minus--%>
                                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                            </button>

                    </div>
                    <div class="col-sm-2 line-center"><%=totalprice%></div>
                    <div class="col-sm-1 line-center">
                        <button class="btn btn-danger" onclick="javascript:location.href='cart.jsp?action=down&bookid=<%=rs.getString(1)%>&number=-1'">删除</button></div>
            </div>
            <%
                    }

                } catch (Exception e){
                    out.println("<script>alert('数据库错误，请联系管理员');</script>");
                }
            %>
            <%--添加增减图书数量的方法--%>
            <%

                if(request.getParameter("action") != null){
                    String _bookid = request.getParameter("bookid");
                    String sNumber = request.getParameter("number");

                    if(_bookid != null && sNumber != null){
                        int _number = Integer.parseInt(sNumber);
                        if("up".equals(request.getParameter("action"))){
                            // 增加
                            _number++;
                        }else if("down".equals(request.getParameter("action"))){
                            // 减小
                            _number--;
                        }
                        sNumber = Integer.toString(_number);
                        if(_number>0){
                            sql = "update cart set number = ? where uid = ? and bookid = ?";
                            pstmt = con.prepareStatement(sql);
                            pstmt.setString(1,sNumber);
                            pstmt.setString(2,username);
                            pstmt.setString(3,_bookid);
                            pstmt.executeUpdate();
                        }else{
                            sql="delete from cart where uid = ? and bookid = ?";
                            pstmt = con.prepareStatement(sql);
                            pstmt.setString(1,username);
                            pstmt.setString(2,_bookid);
                            pstmt.executeUpdate();
                        }


                        response.sendRedirect("cart.jsp");
                    }

               }
            %>

            <div class="col-sm-12 thumbnail">
                <div class=" col-sm-offset-4 col-sm-2 text-right">总数：</div>
                <div class="col-sm-2"><%=globalTotalBook%></div>
                <div class="col-sm-2 text-right">总价：</div>
                <div class="col-sm-2"><%=df.format(globalTotalPrice)%></div>
            </div>
        </div>
        <div class="col-sm-offset-7 col-sm-5" style="padding: 30px;">
            <div class="col-sm-6 btn btn-success btn-block" onclick="javascript:location.href='index.jsp'">继续购物</div>
            <%
                sql = "select * from cart where uid = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1,username);
                rs = pstmt.executeQuery();
                if(rs.next()){
                    %><div class="col-sm-6  btn btn-success btn-block" onclick="javascript:location.href='orderInfo.jsp?action=-1'">提交订单</div><%
                }else{
                    %><div class="col-sm-6  btn disabled btn-block">提交订单</div><%
                }
            %>



        </div>
    </div>
</div>
<%--添加方法，从bookInfo.jsp添加图书时对cart进行操作--%>
<%
    if(request.getParameter("addcart") != null){
        out.println("<script>alert('AAA');</script>");
        sql = "select number from cart where uid = ? and bookid = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1,username);
        pstmt.setString(2,request.getParameter("addcart"));
        rs = pstmt.executeQuery();
        if(rs.next()){
            int number = Integer.parseInt(rs.getString("number"));
            number++;
            sql = "update cart set number = ? where uid = ? and bookid = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1,Integer.toString(number));
            pstmt.setString(2,username);
            pstmt.setString(3,request.getParameter("addcart"));
            // out.println("<script>alert('已增加一本该书至购物车');</script>");
        }else{
            sql = "insert into cart(uid, bookid, number) values (?,?,'1')";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1,username);
            pstmt.setString(2,request.getParameter("addcart"));
            pstmt.executeUpdate();
            // out.println("<script>alert('已将该书添加购物车');</script>");
        }
        response.sendRedirect("cart.jsp");
    }
%>
<!--footer-->
<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
    This Website was developed by QiZQ & MengW & YangXD
</div>
<%
    db.DBCPUtils.closeAll(rs,pstmt,con);
%>
</body>
</html>
