<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
        <jsp:include page="/WEB-INF/jsp/inc/left.jsp">
        	<jsp:param name="left_menu" value="sales" />
        </jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
        <h2 class="sub-header">Sales</h2>
          <div class="table-responsive">


<!-- Main page -->


<script type="text/javascript">
	function modify(){
		var frm=document.detail_form;
		frm.submit();
	}
	
</script>

<form name="detail_form" method="post" action="save_sales.do">
	
<table class="table table-striped">
  <tr>
	<th width="10%">구분</th>
	<th width="25%">입력값</th>
  </tr>
  <tr>
	  <td>영업대표</td>
	  <td><input name="name" value="${project.sales.name}"></td>
  </tr>
  <tr>
	  <td>전화번호</td>
	  <td><input name="tel_no" value="${project.sales.tel_no}"></td>
  </tr>
  <tr>
	  <td>E-Mail</td>
	  <td><input name="email" value="${project.sales.email}"></td>
  </tr>
  
  <tr>
	  <td colspan=2>
	  	<input type="button" value="수정" onClick="javascript:modify();">
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
