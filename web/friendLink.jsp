<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %><%--
  Created by IntelliJ IDEA.
  User: QZQ
  Date: 2018-07-07
  Time: 9:11
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
        img{
            width: 100%;
            height: 200px;
            display: block;
        }
        h3{
            font-size: 20px;
            height: 45px; /* 设置固定高度限制为2行，超高隐藏，防止因标题过长而导致各模块大小不一致*/
            overflow: hidden;
            text-align: center;
        }
        /* 解决不同元素高度混乱问题 */
        .row {
            display: -webkit-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display:         flex;
            flex-wrap: wrap;
        }
        .row > [class*='col-'] {
            display: flex;
            flex-direction: column;
        }

    </style>
    <script>
        function myClick(n){
            location.href = "orderInfo.jsp";
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
                <li class="active"><a href="friendLink.jsp">好书荐购</a></li>
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

<div class="container">
    <div class="row">
        <%
            // 定义变量
            Connection con = db.DBCPUtils.getConnection();


            String sql = "SELECT picpath,bookid,bookname FROM book ORDER BY RAND() LIMIT 20";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
        %>

        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
            <%--<div class="thumbnail" >--%>
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=rs.getString("picpath")%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=rs.getString("bookname")%></h3>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=rs.getString("bookid")%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%
            }
        %>





    </div>
</div>

<!--footer-->
<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
    This Website was developed by QiZQ & MengW & YangXD
</div>
<%
    db.DBCPUtils.closeAll(rs,stmt,con);
%>
</body>
</html>