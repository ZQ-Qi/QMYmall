<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: QZQ
  Date: 2018-07-02
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ page import="DBTest" %>--%>
<html>
<head lang="en">
  <meta charset="UTF-8">

  <link rel="stylesheet" href="css/bootstrap.min.css"/>
  <link rel="stylesheet" href="css/flat-ui.min.css"/>
  <script src="js/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/flat-ui.min.js"></script>
  <title>图书商城</title>
  <style>
    .row{
      margin-top: 20px;;
    }
    .center{
      text-align: center;
    }
    .pagination{
      background: #cccccc;
    }
    img{
      width: 100%;
      height: 200px;
      display: block;
    }
    h3{
      font-size: 20px;
      height: 50px; /* 设置固定高度限制为2行，超高隐藏，防止因标题过长而导致各模块大小不一致*/
      overflow: hidden;
    }
  </style>
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
  // 定义每个图书的bookid(GET方法跳转查书),bookname,price,picpath
  String[][] bookid = new String[4][8];
  String[][] bookname = new String[4][8];
  String[][] price = new String[4][8];
  String[][] picpath = new String[4][8];

  // 连接数据库，获取对应类别下图书数据
  String sql = "select bookid, bookname, price, picpath from book where category = ? ";
  Connection con = db.DBCPUtils.getConnection();
  PreparedStatement pstmt = con.prepareStatement(sql);
  // 检索不同分类下的图书，并将其信息记录于数组中

  pstmt.setString(1,"计算机");
  ResultSet resultSet = pstmt.executeQuery();
  int k = 0;
  for(int i=0;i<8;i++){
      if(resultSet.next()){
          bookid[k][i] = resultSet.getString("bookid");
          bookname[k][i] = resultSet.getString("bookname");
          price[k][i] = resultSet.getString("price");
          picpath[k][i] = resultSet.getString("picpath");
      }else{
          bookid[k][i] = "0000";
          bookname[k][i] = "N/A";
          price[k][i] = "0.00";
          picpath[k][i] = "img/book/0000.jpg";
      }
  }
  pstmt.setString(1,"外语学习");
  resultSet = pstmt.executeQuery();
  k = 1;
  for(int i=0;i<8;i++){
      if(resultSet.next()){
          bookid[k][i] = resultSet.getString("bookid");
          bookname[k][i] = resultSet.getString("bookname");
          price[k][i] = resultSet.getString("price");
          picpath[k][i] = resultSet.getString("picpath");
      }else{
          bookid[k][i] = "0000";
          bookname[k][i] = "N/A";
          price[k][i] = "0.00";
          picpath[k][i] = "img/book/0000.jpg";
      }
  }
  pstmt.setString(1,"经济管理");
  resultSet = pstmt.executeQuery();
  k = 2;
  for(int i=0;i<8;i++){
      if(resultSet.next()){
          bookid[k][i] = resultSet.getString("bookid");
          bookname[k][i] = resultSet.getString("bookname");
          price[k][i] = resultSet.getString("price");
          picpath[k][i] = resultSet.getString("picpath");
      }else{
          bookid[k][i] = "0000";
          bookname[k][i] = "N/A";
          price[k][i] = "0.00";
          picpath[k][i] = "img/book/0000.jpg";
      }
  }
  pstmt.setString(1,"社会科学");
  resultSet = pstmt.executeQuery();
  k = 3;
  for(int i=0;i<8;i++){
      if(resultSet.next()){
          bookid[k][i] = resultSet.getString("bookid");
          bookname[k][i] = resultSet.getString("bookname");
          price[k][i] = resultSet.getString("price");
          picpath[k][i] = resultSet.getString("picpath");
      }else{
          bookid[k][i] = "0000";
          bookname[k][i] = "N/A";
          price[k][i] = "0.00";
          picpath[k][i] = "img/book/0000.jpg";
      }
  }
  db.DBCPUtils.closeAll(resultSet,pstmt,con);
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
  <div class="jumbotron">
    <h1>QMY图书商城</h1>
      <p>欢迎光临！</p>
      <p>作者：亓志强(15069130060)、孟玮(15069130055)、杨肖栋(15069130066)</p>
    <p><a class="btn btn-primary btn-lg" href="mailto:zq_qi1997@163.com" role="button">联系作者</a></p>
  </div>

  <ul class="nav nav-tabs" id="myTabs">
      <%--加入data-toggle=tab目的为避免页面随靶点乱动--%>
    <li class="active"><a href="#tab1" data-toggle="tab" >计算机</a></li>
    <li><a href="#tab2" data-toggle="tab">外语学习</a></li>
    <li><a href="#tab3" data-toggle="tab">经济管理</a></li>
    <li><a href="#tab4" data-toggle="tab">社会科学</a></li>
  </ul>
  <div class="tab-content">
    <div class="tab-pane active" id="tab1">
        <%
            k = 0;
        %>
        <div class="row">
            <%--图书No1--%>
            <div class="col-sm-4 col-md-3">
                <div class="thumbnail" >
                    <a href="bookInfo.jsp">
                        <img alt="100%x200" src="<%=picpath[k][0]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                    </a>
                    <div class="caption center">
                        <h3><%=bookname[k][0]%></h3>
                        <p><span>价格:</span><span><%=price[k][0]%></span></p>
                        <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][0]%>">查看详情</a></p>
                    </div>
                </div>
            </div>
            <%--图书No2--%>
            <div class="col-sm-4 col-md-3">
                <div class="thumbnail" >
                    <a href="bookInfo.jsp">
                        <img alt="100%x200" src="<%=picpath[k][1]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                    </a>
                    <div class="caption center">
                        <h3><%=bookname[k][1]%></h3>
                        <p><span>价格:</span><span><%=price[k][1]%></span></p>
                        <p><a class="btn btn-primary btn-block" role="button" href=bookInfo.jsp?bookid=<%=bookid[k][1]%>>查看详情</a></p>
                    </div>
                </div>
            </div>
            <%--图书No3--%>
            <div class="col-sm-4 col-md-3">
                <div class="thumbnail" >
                    <a href="bookInfo.jsp">
                        <img alt="100%x200" src="<%=picpath[k][2]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                    </a>
                    <div class="caption center">
                        <h3><%=bookname[k][2]%></h3>
                        <p><span>价格:</span><span><%=price[k][2]%></span></p>
                        <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][2]%>">查看详情</a></p>
                    </div>
                </div>
            </div>
            <%--图书No4--%>
            <div class="col-sm-4 col-md-3">
                <div class="thumbnail" >
                    <a href="bookInfo.jsp">
                        <img alt="100%x200" src="<%=picpath[k][3]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                    </a>
                    <div class="caption center">
                        <h3><%=bookname[k][3]%></h3>
                        <p><span>价格:</span><span><%=price[k][3]%></span></p>
                        <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][3]%>">查看详情</a></p>
                    </div>
                </div>
            </div>
            <%--图书No5--%>
            <div class="col-sm-4 col-md-3">
                <div class="thumbnail" >
                    <a href="bookInfo.jsp">
                        <img alt="100%x200" src="<%=picpath[k][4]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                    </a>
                    <div class="caption center">
                        <h3><%=bookname[k][4]%></h3>
                        <p><span>价格:</span><span><%=price[k][4]%></span></p>
                        <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][4]%>">查看详情</a></p>
                    </div>
                </div>
            </div>
            <%--图书No6--%>
            <div class="col-sm-4 col-md-3">
                <div class="thumbnail" >
                    <a href="bookInfo.jsp">
                        <img alt="100%x200" src="<%=picpath[k][5]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                    </a>
                    <div class="caption center">
                        <h3><%=bookname[k][5]%></h3>
                        <p><span>价格:</span><span><%=price[k][5]%></span></p>
                        <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][5]%>">查看详情</a></p>
                    </div>
                </div>
            </div>
            <%--图书No7--%>
            <div class="col-sm-4 col-md-3">
                <div class="thumbnail" >
                    <a href="bookInfo.jsp">
                        <img alt="100%x200" src="<%=picpath[k][6]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                    </a>
                    <div class="caption center">
                        <h3><%=bookname[k][6]%></h3>
                        <p><span>价格:</span><span><%=price[k][6]%></span></p>
                        <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][6]%>">查看详情</a></p>
                    </div>
                </div>
            </div>
            <%--图书No8--%>
            <div class="col-sm-4 col-md-3">
                <div class="thumbnail" >
                    <a href="bookInfo.jsp">
                        <img alt="100%x200" src="<%=picpath[k][7]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                    </a>
                    <div class="caption center">
                        <h3><%=bookname[k][7]%></h3>
                        <p><span>价格:</span><span><%=price[k][7]%></span></p>
                        <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][7]%>">查看详情</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="tab-pane" id="tab2">
        <%
            k = 1;
        %>
        <div class="row">
        <%--图书No1--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][0]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][0]%></h3>
                    <p><span>价格:</span><span><%=price[k][0]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][0]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No2--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][1]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][1]%></h3>
                    <p><span>价格:</span><span><%=price[k][1]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href=bookInfo.jsp?bookid=<%=bookid[k][1]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No3--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][2]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][2]%></h3>
                    <p><span>价格:</span><span><%=price[k][2]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][2]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No4--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][3]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][3]%></h3>
                    <p><span>价格:</span><span><%=price[k][3]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][3]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No5--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][4]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][4]%></h3>
                    <p><span>价格:</span><span><%=price[k][4]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][4]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No6--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][5]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][5]%></h3>
                    <p><span>价格:</span><span><%=price[k][5]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][5]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No7--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][6]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][6]%></h3>
                    <p><span>价格:</span><span><%=price[k][6]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][6]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No8--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][7]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][7]%></h3>
                    <p><span>价格:</span><span><%=price[k][7]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][7]%>">查看详情</a></p>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="tab-pane" id="tab3">
        <%
            k = 2;
        %>
        <div class="row">
        <%--图书No1--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][0]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][0]%></h3>
                    <p><span>价格:</span><span><%=price[k][0]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][0]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No2--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][1]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][1]%></h3>
                    <p><span>价格:</span><span><%=price[k][1]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href=bookInfo.jsp?bookid=<%=bookid[k][1]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No3--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][2]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][2]%></h3>
                    <p><span>价格:</span><span><%=price[k][2]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][2]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No4--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][3]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][3]%></h3>
                    <p><span>价格:</span><span><%=price[k][3]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][3]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No5--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][4]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][4]%></h3>
                    <p><span>价格:</span><span><%=price[k][4]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][4]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No6--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][5]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][5]%></h3>
                    <p><span>价格:</span><span><%=price[k][5]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][5]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No7--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][6]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][6]%></h3>
                    <p><span>价格:</span><span><%=price[k][6]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][6]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No8--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][7]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][7]%></h3>
                    <p><span>价格:</span><span><%=price[k][7]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][7]%>">查看详情</a></p>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="tab-pane" id="tab4">
        <%
            k = 3;
        %>
        <div class="row">
        <%--图书No1--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][0]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][0]%></h3>
                    <p><span>价格:</span><span><%=price[k][0]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][0]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No2--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][1]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][1]%></h3>
                    <p><span>价格:</span><span><%=price[k][1]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href=bookInfo.jsp?bookid=<%=bookid[k][1]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No3--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][2]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][2]%></h3>
                    <p><span>价格:</span><span><%=price[k][2]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][2]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No4--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][3]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][3]%></h3>
                    <p><span>价格:</span><span><%=price[k][3]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][3]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No5--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][4]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][4]%></h3>
                    <p><span>价格:</span><span><%=price[k][4]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][4]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No6--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][5]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][5]%></h3>
                    <p><span>价格:</span><span><%=price[k][5]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][5]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No7--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][6]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][6]%></h3>
                    <p><span>价格:</span><span><%=price[k][6]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][6]%>">查看详情</a></p>
                </div>
            </div>
        </div>
        <%--图书No8--%>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail" >
                <a href="bookInfo.jsp">
                    <img alt="100%x200" src="<%=picpath[k][7]%>" data-src="holder.js/100%x200" data-holder-rendered="false">
                </a>
                <div class="caption center">
                    <h3><%=bookname[k][7]%></h3>
                    <p><span>价格:</span><span><%=price[k][7]%></span></p>
                    <p><a class="btn btn-primary btn-block" role="button" href="bookInfo.jsp?bookid=<%=bookid[k][7]%>">查看详情</a></p>
                </div>
            </div>
        </div>
    </div>
    </div>
  </div>
  <div class="row"></div>

</div>
<!--footer-->
<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
  This Website was developed by QiZQ & MengW & YangXD
</div>
</body>
</html>