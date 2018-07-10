<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.DecimalFormat" %><%--
  Created by IntelliJ IDEA.
  User: QZQ
  Date: 2018-07-07
  Time: 9:14
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
            width: 200px;;
        }
        td{
            text-align: left;
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
</head>
<body>
<%
    // 初始化
    request.setCharacterEncoding("utf-8");
    // 设置变量
    String username = "N/A";
    String action = "-1";
    int globalNum = 0;
    double globalPrice = 0;
    DecimalFormat df = new DecimalFormat("######0.00");
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = "";
    // 检查是否已登录
    if(session.getAttribute("username") == null){
        response.sendRedirect("login.jsp?err=2");
    }else{
        username = session.getAttribute("username").toString();
    }

    // 检查是否传值，若无购物车(-1)或商品页(bookid)传值，则跳转回首页
    if(request.getParameter("action") == null){
        response.sendRedirect("index.jsp");
    }else{
        action = request.getParameter("action");
    }

    // 连接数据库
    con = db.DBCPUtils.getConnection();
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
    <div class="row thumbnail center col-sm-12">
        <div class="col-sm-12">
            <h1 class="text-center" style="margin-bottom: 30px">订单详情</h1>
        </div>

        <div class="col-sm-12 ">

            <%--------------------------------------------------------------------------%>
            <%--获取用户信息为默认收货人信息--%>
            <%
                sql = "select * from user where uid = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1,username);
                rs = pstmt.executeQuery();
                rs.next();

            %>

            <form class="form-horizontal caption" id="receiverForm" data-toggle="validator" action="order.jsp" method="post">
                <div class="form-group">
                    <label for="rname" class="col-sm-3 control-label">收货人</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="rname" name="rname"
                               placeholder="收货人" value="<%=rs.getString("uid")%>"
                               data-error="收货人为必填项" required>
                    </div>
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <label for="rtelephone" class="col-sm-3 control-label">电话</label>
                    <div class="col-sm-6">
                        <input type="tel" class="form-control" id="rtelephone" name="rtelephone"
                               placeholder="电话号码"  value="<%=rs.getString("telephone")%>"
                               pattern="^[1][0-9]{10}$" required>
                    </div>
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <label for="raddress" class="col-sm-3 control-label">地址</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="raddress" name="raddress"
                               value="<%=rs.getString("address")%>"
                               placeholder="地址" required>
                    </div>
                    <div class="help-block with-errors"></div>
                </div>
                <div style="visibility: hidden">
                    <input type="text" name="action" value="<%=action%>">
                </div>
            </form>
            <%--------------------------------------------------------------------------%>
        </div>
        <div class="col-sm-12">
            <table class="table table-striped table-condensed">
                <tr>
                    <th>书名</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                </tr>
                <%
                    if(Integer.parseInt(action) == -1){
                        // 购买购物车的所有物品
                        sql = "select bookname,price,number from book,cart where book.bookid = cart.bookid and uid = ?";
                        pstmt = con.prepareStatement(sql);
                        pstmt.setString(1,username);
                        rs = pstmt.executeQuery();
                        while(rs.next()){
                            double singlePrice = Double.parseDouble(rs.getString("price"));
                            int singleNum = Integer.parseInt(rs.getString("number"));
                            String total = df.format(singlePrice * singleNum);
                            globalNum += singleNum;
                            globalPrice += singlePrice * singleNum;
                            %>
                <tr>
                    <td><%=rs.getString("bookname")%></td>
                    <td><%=rs.getString("price")%></td>
                    <td><%=rs.getString("number")%></td>
                    <td><%=total%></td>
                </tr>
                <%
                        }
                    }else{
                        sql = "select bookname, price from book where bookid = ?";
                        pstmt = con.prepareStatement(sql);
                        pstmt.setString(1,action);
                        rs = pstmt.executeQuery();
                        if(rs.next()){
                            globalNum ++;
                            globalPrice = Double.parseDouble(rs.getString("price"));
                %>
                <tr>
                    <td><%=rs.getString("bookname")%></td>
                    <td><%=rs.getString("price")%></td>
                    <td><%=1%></td>
                    <td><%=rs.getString("price")%></td>
                </tr>
                <%
                        }
                    }
                %>
                <tr></tr>
            </table>

        </div>

        <div class="col-sm-12 ">
            <table>
                <tr>
                    <th> </th><th></th>
                    <th>商品总数：</th><td><%=globalNum%></td>
                    <th>订单总价：</th><td><span class="text-danger"><%=df.format(globalPrice)%></span></td>
                </tr>
            </table>
        </div>
    </div>
    <div></div>
    <div class="col-sm-offset-7 col-sm-5" style="padding: 30px;">
        <div class="col-sm-6 btn btn-success btn-block" onclick="javascript:location.href='index.jsp'">继续购物</div>
        <div class="col-sm-6  btn btn-success btn-block" onclick="submitIt()">提交订单</div>
    </div>
</div>
<script>
    function submitIt(){
        document.getElementById("receiverForm").submit();
    }
</script>
<%--结束数据库连接--%>
<%
    db.DBCPUtils.closeAll(rs,pstmt,con);
%>
<!--footer-->
<div class="navbar navbar-default navbar-static-bottom " style="text-align: center">
    This Website was developed by QiZQ & MengW & YangXD
</div>
</body>
</html>
