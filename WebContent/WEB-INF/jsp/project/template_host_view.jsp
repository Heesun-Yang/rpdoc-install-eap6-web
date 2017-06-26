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
        	<jsp:param name="left_menu" value="template_host" />
        </jsp:include>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
        <h2 class="sub-header">Template Host 정보</h2>
          <div class="table-responsive">


<!-- Main page -->
<script type="text/javascript">
	function save_template_host(){
		var frm=document.save_template_host_form;
		frm.submit();
	}
	
</script>

<form name="detail_form" method="post">
	
<table class="table table-striped">
  <tr>
	<th width="15%">구분</th>
	<th width="35%">입력값</th>
	<th width="50%">설명</th>
  </tr>
  <tr>
	  <td>IP</td>
	  <td>${project.template_host.ip}</td>
	  <td>Template Host의 IP</td>
  </tr>
  <tr>
	  <td>OS User ID</td>
	  <td>${project.template_host.os_user_id}</td>
	  <td>Template Host에서 사용할 OS User ID</td>
  </tr>
  <tr>
	  <td>OS User PW</td>
	  <td>${project.template_host.os_user_pw}</td>
	  <td>Template Host에서 사용할 OS User Password</td>
  </tr>
  
  <tr>
	  <td>Directory Path</td>
	  <td>${project.template_host.template_path}</td>
	  <td>Template Host에서 사용할 Directory 경로</td>
  </tr>
  
  <tr>
	  <td colspan=3>
	  	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#saveTemplateHostModal">수정</button>
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
<div id="saveTemplateHostModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- dialog body -->
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
        <form name="save_template_host_form" method="post" action="${pageContext.request.contextPath}/project/save_template_host.do">
        	<div class="form-group">
            <label for=ip class="control-label">Host IP:</label>
            <input name="ip" type="text" class="form-control" id="ip" value="">
          </div>
          <div class="form-group">
            <label for=os_user_id class="control-label">OS User ID:</label>
            <input name="os_user_id" type="text" class="form-control" id="os_user_id" value="">
          </div>
          <div class="form-group">
            <label for=os_user_pw class="control-label">OS User PW:</label>
            <input name="os_user_pw" type="text" class="form-control" id="os_user_pw" value="">
          </div>
          <div class="form-group">
            <label for=template_path class="control-label">Directory Path:</label>
            <input name="template_path" type="text" class="form-control" id="template_path" value="">
          </div>
          
        </form>
      </div>
      <!-- dialog buttons -->
       <div class="modal-footer">
      		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      		<button type="button" class="btn btn-primary" onClick="javascript:save_template_host();">수정</button>
      	</div>
    </div>
  </div>
</div>

<script type="text/javascript">
$('#saveTemplateHostModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  //var ip = button.data('ip') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Template Host 정보를 수정합니다.')
	  modal.find('.modal-body #ip').val("${project.template_host.ip}")
	  modal.find('.modal-body #os_user_id').val("${project.template_host.os_user_id}")
	  modal.find('.modal-body #os_user_pw').val("${project.template_host.os_user_pw}")
	  modal.find('.modal-body #template_path').val("${project.template_host.template_path}")
	  
})
</script>