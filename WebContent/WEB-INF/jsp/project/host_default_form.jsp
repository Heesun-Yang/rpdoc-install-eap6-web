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
        	<jsp:param name="left_menu" value="host_default" />
        </jsp:include>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
        <h2 class="sub-header">Target Host 기본값</h2>
          <div class="table-responsive">


<!-- Main page -->
<script type="text/javascript">
	function modify(){
		var frm=document.detail_form;
		frm.submit();
	}
	
</script>

<form name="detail_form" method="post" action="save_host_default.do">
	
<table class="table table-striped">
  <tr>
	<th width="15%">구분</th>
	<th width="35%">입력값</th>
	<th width="50%">설명</th>
  </tr>
  <tr>
	  <td>OS User ID</td>
	  <td><input name="os_user_id" value="${project.host_default_values.os_user_id}"></td>
	  <td>Host에서 사용할 OS User ID</td>
  </tr>
  <tr>
	  <td>OS User PW</td>
	  <td><input name="os_user_pw" value="${project.host_default_values.os_user_pw}"></td>
	  <td>Host에서 사용할 OS User Password</td>
  </tr>
  <tr>
	  <td>Root PW</td>
	  <td><input name="os_root_pw" value="${project.host_default_values.os_root_pw}"></td>
	  <td>Host의 Root PW</td>
  </tr>
  <tr>
	  <td>JAVA_HOME 경로</td>
	  <td><input name="java_home" value="${project.host_default_values.java_home}"></td>
	  <td>Host에서 사용할 JAVA_HOME 경로</td>
  </tr>
  <tr>
	  <td>JBOSS_HOME 경로</td>
	  <td><input name="jboss_home" value="${project.host_default_values.jboss_home}"></td>
	  <td>Host에서 사용할 JBOSS_HOME 경로</td>
  </tr>
  <tr>
	  <td>DOMAIN_BASE 경로</td>
	  <td><input name="domain_base" value="${project.host_default_values.domain_base}"></td>
	  <td>Host에서 사용할 DOMAIN_BASE 경로</td>
  </tr>
  
  <tr>
	  <td colspan=3>
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
