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
	function save_host_default(){
		var frm=document.save_host_default_form;
		frm.submit();
	}
	
</script>

<form name="detail_form" method="post" action="edit_host_default.do">
	
<table class="table table-striped">
  <tr>
	<th width="15%">구분</th>
	<th width="35%">입력값</th>
	<th width="50%">설명</th>
  </tr>
  <tr>
	  <td>OS User ID</td>
	  <td>${project.host_default_values.os_user_id}</td>
	  <td>Host에서 사용할 OS User ID</td>
  </tr>
  <tr>
	  <td>OS User PW</td>
	  <td>${project.host_default_values.os_user_pw}</td>
	  <td>Host에서 사용할 OS User Password</td>
  </tr>
  <tr>
	  <td>Root PW</td>
	  <td>${project.host_default_values.os_root_pw}</td>
	  <td>Host의 Root PW</td>
  </tr>
  <tr>
	  <td>JAVA_HOME 경로</td>
	  <td>${project.host_default_values.java_home}</td>
	  <td>Host에서 사용할 JAVA_HOME 경로</td>
  </tr>
  <tr>
	  <td>JBOSS_HOME 경로</td>
	  <td>${project.host_default_values.jboss_home}</td>
	  <td>Host에서 사용할 JBOSS_HOME 경로</td>
  </tr>
  <tr>
	  <td>DOMAIN_BASE 경로</td>
	  <td>${project.host_default_values.domain_base}</td>
	  <td>Host에서 사용할 DOMAIN_BASE 경로</td>
  </tr>
  
  <tr>
	  <td colspan=3>
	  	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#saveHostDefaultModal">수정</button>
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

<!-- Modal -->
<div id="saveHostDefaultModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- dialog body -->
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
        <form name="save_host_default_form" method="post" action="${pageContext.request.contextPath}/project/save_host_default.do">
        	<div class="form-group">
            <label for=os_user_id class="control-label">OS User ID:</label>
            <input name="os_user_id" type="text" class="form-control" id="os_user_id" value="">
          </div>
          <div class="form-group">
            <label for=os_user_pw class="control-label">OS User PW:</label>
            <input name="os_user_pw" type="text" class="form-control" id="os_user_pw" value="">
          </div>
          <div class="form-group">
            <label for=os_root_pw class="control-label">Root PW:</label>
            <input name="os_root_pw" type="text" class="form-control" id="os_root_pw" value="">
          </div>
          <div class="form-group">
            <label for=java_home class="control-label">JAVA_HOME 경로:</label>
            <input name="java_home" type="text" class="form-control" id="java_home" value="">
          </div>
          <div class="form-group">
            <label for=jboss_home class="control-label">JBOSS_HOME 경로:</label>
            <input name="jboss_home" type="text" class="form-control" id="jboss_home" value="">
          </div>
          <div class="form-group">
            <label for=domain_base class="control-label">DOMAIN_BASE 경로:</label>
            <input name="domain_base" type="text" class="form-control" id="domain_base" value="">
          </div>
          
          
        </form>
      </div>
      <!-- dialog buttons -->
       <div class="modal-footer">
      		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      		<button type="button" class="btn btn-primary" onClick="javascript:save_host_default();">수정</button>
      	</div>
    </div>
  </div>
</div>

<script type="text/javascript">
$('#saveHostDefaultModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  //var ip = button.data('ip') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Target Host 기본값을 수정합니다.')
	  modal.find('.modal-body #os_user_id').val("${project.host_default_values.os_user_id}")
	  modal.find('.modal-body #os_user_pw').val("${project.host_default_values.os_user_pw}")
	  modal.find('.modal-body #os_root_pw').val("${project.host_default_values.os_root_pw}")
	  modal.find('.modal-body #java_home').val("${project.host_default_values.java_home}")
	  modal.find('.modal-body #jboss_home').val("${project.host_default_values.jboss_home}")
	  modal.find('.modal-body #domain_base').val("${project.host_default_values.domain_base}")
	  
})
</script>