<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Login</title>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

    <style>
    body{
        background-color:#898787;
    }
    .top-buffer {
        margin-top:20px;
    }
    .jumbotron{
        background: url(images/soft_white_background.jpg) center center;
        width: 100%;
        background-size: cover;
    }
    .container-fluid{
        width:80%;
    }
    #divheader{
     background-color: #aa80ff;
          color:white !important;
          text-align: center;
    }
    #divheader h2{
        vertical-align: middle;
    }
    </style>

</head>

<body>

<div class="container-fluid">
        <div class="jumbotron">
        <div class="top-buffer" id="divheader">
        <h2><b>Welcome to Translation <%= session.getAttribute("sessionname")%>... !</b></h2>
        </div>
        <br>
        <form role="form" action="TranslateServlet" method="post">
        <div class="row top-buffer">

            <div class="col-md-2"></div>
          <div class="col-md-4">
              <strong>From:</strong> <br/>
              <%
              out.println("<textarea name=\"txtFromText\">");
                    String s1 = (String) request.getAttribute("fromText");
                        if (s1!= null) {
                            out.println(s1);
                    }
                 out.println("</textarea>");
              %>
              <br>
              <div class="top-buffer">
              <select name="frmType" class="form-control" style="width:150px;">
                  <%
                  ArrayList<String> ar=new ArrayList<String>();
                  ar=(ArrayList<String>)request.getAttribute("list");

                      for(int i=0; i<ar.size(); i++){
                      if(ar.get(i).equals(request.getAttribute("selectedFrom"))){
                      out.println("<option selected>"+ar.get(i)+"</option>");
                      }else{
                      out.println("<option>"+ar.get(i)+"</option>");
                      }
                      }
                      %>
              </select>
              </div>
          </div>

            <div class="col-md-4">
               <strong> To:</strong> <br>
                <%
                out.println("<textarea name=\"txtToText\">");
                    String s2 = (String) request.getAttribute("textreply");
                        if (s2 != null) {
                            out.println(s2);
                        }
                out.println("</textarea>");
                %>

                <br>
                <div class="top-buffer">
                <select name="toType" class="form-control" style="width:150px;">
                    <%
                    ArrayList<String> ar2=new ArrayList<String>();
                    ar2=(ArrayList<String>)request.getAttribute("list");

                        for(int i=0; i<ar2.size(); i++){
                        if(ar2.get(i).equals(request.getAttribute("selectedTo"))){
                        out.println("<option selected>"+ar2.get(i)+"</option>");
                        }else{
                        out.println("<option>"+ar2.get(i)+"</option>");
                        }
                        }
                        %>
                </select>
                </div>
            </div>
            <div class="col-md-2"></div>
            </div>
                <div class="top-buffer" style="margin:5% 50% 0 30%;">
                    <input type="submit" class="btn btn-default btn-block" value="Translate">
                </div>
            </form>
            <br>
            <div class="row top-buffer">
                <form action="LogoutServlet" method="get">
                    <span class="glyphicon glyphicon-log-out"></span><input type="submit" class="btn btn-default" value="Logout" align="right"/>
                </form>
                  <div class="row">
                        <h5><b>Powered by Yandex.Translate: </b><a href="http://translate.yandex.com/"> http://translate.yandex.com/</a></h5>
                  </div>
            </div>
        </div>
    </div>
</body>
</html>
