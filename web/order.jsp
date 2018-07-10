<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %><%--
  Created by IntelliJ IDEA.
  User: QZQ
  Date: 2018-07-07
  Time: 9:13
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
        .list-group-item:hover{
            background: #27ae60;

        }
        .list-group-item div:first-child:hover{

            cursor: pointer;
        }
    </style>
    <script>

        function btnClick(){
            alert("btn");
            return false;
        }
        $(function(){

        })
    </script>
</head>
<body>
<%
    // 页面初始化
    request.setCharacterEncoding("utf-8");
    // 设置变量
    String username = "N/A";
    String action = "";
    DecimalFormat dec = new DecimalFormat("######0.00");
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = "";
    // 判断用户是否登陆
    if(session.getAttribute("username") == null){
        response.sendRedirect("login.jsp?err=2");
    }else{
        username = session.getAttribute("username").toString();
    }
    // 建立数据库连接
    con = db.DBCPUtils.getConnection();
%>

<%
    // 如果由提交订单页面传值进行订单提交操作，则执行下列代码块
    if(request.getParameter("action") != null){

        action = request.getParameter("action");
        // 创建订单号 时间+username
        String orderId = System.currentTimeMillis()+username;
        // 引入收件人、收件人地址、收件人电话
        String rname = request.getParameter("rname");
        String raddress = request.getParameter("raddress");
        String rtelephone = request.getParameter("rtelephone");
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");

        sql  = "insert into orderlist values(?,?,?,?,?,?,?)";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1,orderId);
        pstmt.setString(2,username);
        pstmt.setString(3,df.format(new Date()));
        pstmt.setString(4,"未付款");
        pstmt.setString(5,rname);
        pstmt.setString(6,raddress);
        pstmt.setString(7,rtelephone);
        if("-1".equals(action)){
            // 插入orderlist表
            out.println("<script>console.log('执行整体订单操作');</script>");
            if(pstmt.executeUpdate() == 1){
                ArrayList<String> alBookid = new ArrayList();
                ArrayList<String> alPrice = new ArrayList();
                ArrayList<String> alNumber = new ArrayList();

                sql = "select cart.bookid,price,number from cart,book where cart.bookid=book.bookid and uid = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1,username);
                rs = pstmt.executeQuery();
                while(rs.next()){
                    alBookid.add(rs.getString(1));
                    alPrice.add(rs.getString(2));
                    alNumber.add(rs.getString(3));
                }
                String[] arBookid = alBookid.toArray(new String[alBookid.size()]);
                String[] arPrice = alPrice.toArray(new String[alPrice.size()]);
                String[] arNumber = alNumber.toArray(new String[alNumber.size()]);
                sql = "insert into orderdetail values(?,?,?,?)";
                for(int i = 0;i<arBookid.length;i++){
                    pstmt = con.prepareStatement(sql);
                    double pri = Double.parseDouble(arPrice[i]);
                    int n = Integer.parseInt(arNumber[i]);
                    out.println("<script>console.log('"+arNumber[i]+"');</script>");
                    String totalPrice = dec.format(pri * n);
                    pstmt.setString(1,orderId);
                    pstmt.setString(2,arBookid[i]);
                    pstmt.setString(3,arNumber[i]);
                    pstmt.setString(4,totalPrice);
                    pstmt.executeUpdate();

                }
                sql = "delete from cart where uid = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1,username);
                pstmt.executeUpdate();
                out.println("<script>alert('订单提交成功！');</script>");
            }else{
            }
        }else if(rname != null && raddress != null && rtelephone != null){
            out.println("<script>console.log('执行单个订单操作');</script>");
            if(pstmt.executeUpdate() == 1){
                sql = "select price from book where bookid = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1,action);
                rs = pstmt.executeQuery();
                if(rs.next()){
                    String price = rs.getString("price");
                    sql = "insert into orderdetail values(?,?,'1',?)";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1,orderId);
                    pstmt.setString(2,action);
                    pstmt.setString(3,price);
                    if(pstmt.executeUpdate() == 1){
                        out.println("<script>alert('订单提交成功！');</script>");
                    }else{
                        out.println("<script>alert('订单提交失败！');</script>");
                    }
                }
            }


        }
    }
%>

<!-- Static navbar -->
<div class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"></button>
            <a class="navbar-brand" href="index.jsp">图书商城</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="index.jsp">首页</a></li>
                <li class="active"><a href="order.jsp">我的订单</a></li>
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
    <div class="row thumbnail center">
        <div class="col-sm-12">
            <h1 class="text-center" style="margin-bottom: 30px">我的订单</h1>
        </div>
        <div class="col-sm-12 thumbnail">
            <div class="col-sm-3 line-center">订单编号</div>
            <div class="col-sm-2 line-center">订单状态</div>
            <div class="col-sm-2 line-center">商品数量 </div>
            <div class="col-sm-2 line-center">订单总价</div>
            <div class="col-sm-3 line-center">操作</div>
        </div>
        <div class="list-group">
            <%
                // 查询订单列表
                sql = "select orderlist.orderid, status, count(bookid), sum(tprice)  from orderlist,orderdetail where orderlist.orderid = orderdetail.orderid and uid = ? group by orderdetail.orderid;";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1,username);
                rs = pstmt.executeQuery();
                while(rs.next()){

                    %>
            <div class="col-sm-12  list-group-item" >
                <div class="col-sm-3 line-center"><%=rs.getString(1)%></div>
                <div class="col-sm-2 line-center"><%=rs.getString(2)%></div>
                <div class="col-sm-2 line-center"><%=rs.getString(3)%></div>
                <div class="col-sm-2 line-center"><%=rs.getString(4)%> 元</div>
                <div class="col-sm-3 line-center">
                    <button class="btn btn-danger" onclick="javascript:location.href='order.jsp?func=deleteit&orderid=<%=rs.getString(1)%>'">删除订单</button>
                    <button class="btn btn-success" onclick="javascript:location.href='order.jsp?func=finishit&orderid=<%=rs.getString(1)%>'">完成订单</button>
                </div>
            </div>
            <%
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
    // 执行订单删除和订单完成操作
    if(request.getParameter("func") != null && request.getParameter("orderid") != null){
        String func = request.getParameter("func");
        String orderid = request.getParameter("orderid");
        if("deleteit".equals(func)){
            sql = "delete from orderlist where orderid = ?";
        }else{
            sql = "update orderlist set status = '已完成' where orderid = ?";
        }
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1,orderid);
        pstmt.executeUpdate();
        response.sendRedirect("order.jsp");
    }
%>

<%
    // 结束数据库连接
    db.DBCPUtils.closeAll(rs,pstmt,con);
%>
</body>
</html>
