<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0); // Proxies. 

%>


<!DOCTYPE html>

<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <link rel="icon" href="<%=request.getContextPath()%>/resources/img/favicon.ico">
	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>

    <title>Dashboard Template for Bootstrap</title>
	<%-- <script src="<%=request.getContextPath()%>/resources/dist/js/jquery.min.js"></script> --%>
    <%-- <script src="<%=request.getContextPath()%>/resources/dist/js/bootstrap.min.js"></script> --%>
     <script type="text/javascript" src="//code.jquery.com/jquery-2.1.4.js"></script>
     <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.9.4/js/bootstrap-select.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/dist//css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.9.4/css/bootstrap-select.min.css">
	
	
    <!-- Bootstrap core CSS -->
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <!-- Custom styles for this template -->
    <%-- 
    <link href="<%=request.getContextPath()%>/resources/dist/css/bootstrap.min.css" rel="stylesheet">

    <link href="<%=request.getContextPath()%>/resources/dist/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
 --%>
 
    <link href="<%=request.getContextPath()%>/resources/dist/css/dashboard.css" rel="stylesheet">

    


  </head>
  

  <body>