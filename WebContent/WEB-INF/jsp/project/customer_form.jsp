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
        	<jsp:param name="left_menu" value="customer" />
        </jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
        <h2 class="sub-header">고객정보입력</h2>
          <div class="table-responsive">


<!-- Main page -->


<script type="text/javascript">
	function modify(){
		var frm=document.detail_form;
		frm.submit();
	}
	
</script>

<form name="detail_form" method="post" action="${pageContext.request.contextPath}/project/save_customer.do">
	
<table class="table table-striped">
  <tr>
	<th width="10%">구분</th>
	<th width="25%">입력값</th>
  </tr>
  <tr>
	  <td>고객명</td>
	  <td><input name="name" value="${project.customer.name}"></td>
  </tr>
  <tr>
	  <td>장소</td>
	  <td><input name="inspection_place" value="${project.customer.inspection_place}"></td>
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
