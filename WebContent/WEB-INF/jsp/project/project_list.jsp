<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="java.util.*" %>
<%@ page import="com.rp.project.dto.Customer" %>
<%@ page import="org.slf4j.Logger" %>
<%@ page import="org.slf4j.LoggerFactory" %>
<%!
 static Logger logger = LoggerFactory.getLogger("jsp"); //log4j를 위해 
%>



<jsp:include page="/WEB-INF/jsp/inc/header.jsp"></jsp:include>

<jsp:include page="/WEB-INF/jsp/inc/top.jsp"></jsp:include>

    <div class="container-fluid">
      <div class="row">
        <%-- <jsp:include page="/WEB-INF/jsp/inc/left.jsp"></jsp:include> --%>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
        <h2 class="sub-header">Project 목록</h2>
          <div class="table-responsive">


<!-- Main page -->

<script type="text/javascript">
	function add_project(){
		var frm=document.detail_form;
		frm.submit();
	}
	
</script>

<form name="detail_form" method="post" action="${pageContext.request.contextPath}/index.jsp">
	
<table class="table table-striped">
	<tr>
		<th width="10%">순번</th>
		<th width="50%">프로젝트명</th>
		<th width="40%">UUID</th>
	</tr>
  
	<c:if test="${fn:length(list) > 0}">
	  	<c:forEach var="project" items="${list}" varStatus="status">
		<tr>
			<td>${status.count}</td>
		  	<td><a href="${pageContext.request.contextPath}/project/get_project.do?project_name=${project.key}">${project.key}</a></td>
		  	<td><a href="${pageContext.request.contextPath}/project/get_project.do?project_name=${project.key}">${project.value}</a></td>
		</tr>
		</c:forEach>
	</c:if>
	<c:if test="${empty list}">
	  	<tr>
			<td></td>
		  	<td>No Project</td>
		  	<td></td>
		</tr>
	</c:if>
	
	<tr>
	  	<td colspan=3>
	  		<input type="button" value="추가" onClick="javascript:add_project();">
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
