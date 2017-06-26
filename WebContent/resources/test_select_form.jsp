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


<!-- Main page -->

 
 
    <div class="container-fluid">
      <div class="row">
        <jsp:include page="/WEB-INF/jsp/inc/left.jsp">
        	<jsp:param name="left_menu" value="sales" />
        </jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
        <h2 class="sub-header">Sales</h2>
          <div class="table-responsive">





<!-- Main page end -->
	
	
          </div>
        </div>
      </div>
    </div>
    
    <select id="app_id" class="selectpicker">
       <option value="">--Select--</option>
       <option value="1">Application 1</option>
       <option value="2">Application 2</option>
 </select>
<jsp:include page="/WEB-INF/jsp/inc/footer.jsp"></jsp:include>



