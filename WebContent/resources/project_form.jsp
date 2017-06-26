<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.rp.project.dto.Customer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:include page="/WEB-INF/jsp/inc/header.jsp"></jsp:include>

<jsp:include page="/WEB-INF/jsp/inc/top.jsp"></jsp:include>

    <div class="container-fluid">
      <div class="row">
        <!-- Left menu, Project list -->
        <div class="col-sm-3 col-md-2 sidebar">
		  	<ul class="nav nav-sidebar">
            <li><a href="#"><b>Project List</b></a></li>
          </ul>
          
          <ul class="nav nav-sidebar">
            <li><a href="#">Test Project1</a></li>
            <li><a href="#">Test Project2</a></li>
          </ul>
        </div>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
        <h2 class="sub-header">프로젝트 생성</h2>
          <div class="table-responsive">


<!-- Main page -->
<%
// request.setCharacterEncoding("utf-8");


// 신규 프로젝트
if ("add".equals(request.getAttribute("operation_mode")+"")){
	HashMap<String, Object> project = new HashMap<String, Object>();
	session.setAttribute("project", project);
} else if ("edit".equals(request.getAttribute("operation_mode")+"")){
	
}

String contextPath = request.getContextPath();
%>

<script language="javascript">
	function add_project(){
		var frm=document.project_form;
		frm.submit();
	}
	
</script>

<form name="project_form" method="post">
	
<table class="table table-striped">
  <tr>
	<th width="10%">구분</th>
	<th width="25%">입력값</th>
  </tr>
  <tr>
	  <td>프로젝트명:${param.project_name}</td>
	  <td><input name="project_name" value="${param.project_name}"></td>
  </tr>

  <tr>
	  <td colspan=2>
	  	<input type="button" value="등록" onClick="javascript:add_project();">
	  </td>
	  
  </tr>
</table>
</form>

<!-- Main page end -->
	
	
          </div>
        </div>
      </div>
    </div>
<jsp:include page="/WEB-INF/jsp/inc/footer.jsp"></jsp:include>
