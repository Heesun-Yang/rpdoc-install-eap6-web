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
<%
HashMap<String,Object> project = (HashMap<String,Object>)request.getSession().getAttribute("project");
ArrayList<Object> services = (ArrayList<Object>)project.get("services");

request.setAttribute("services", services);


%>
<jsp:include page="/WEB-INF/jsp/inc/header.jsp"></jsp:include>

<jsp:include page="/WEB-INF/jsp/inc/top.jsp"></jsp:include>

    <div class="container-fluid">
      <div class="row">
        <jsp:include page="/WEB-INF/jsp/inc/left.jsp">
        	<jsp:param name="left_menu" value="service" />
        </jsp:include>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
        <h2 class="sub-header">Service List</h2>
          <div class="table-responsive">


<!-- Main page -->
<script type="text/javascript">
	function add_service(){
		var frm=document.add_service_form;
		frm.submit();
	}
	function copy_service(){
		var frm=document.copy_service_form;
		frm.submit();
	}
	function remove_service(){
		var frm=document.remove_service_form;
		frm.submit();
	}
	function save_service(){
		var frm=document.save_service_form;
		frm.submit();
	}
	
	
	
</script>

<form name="detail_form" method="post" action="save_service.do">
	
<table class="table table-striped">
  <tr>
	<th width="20%">Service명</th>
	<th width="20%">WAS Config File</th>
  	<th width="20%">Service Action</th>
	<th width="20%">WEB Host 대수</th>
	<th width="20%">WAS Host 대수</th>
	</tr>
  <c:forEach var="service_map" items="${services}" varStatus="status">
  <tr>
	  <td>
	   		<a href="${pageContext.request.contextPath}/project/get_service.do?name=${service_map.name}">
	  			<b>${service_map.name}</b>
	  		</a> &nbsp;
	  		<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/project/get_service.do?name=${service_map.name}'">Enter</button>
	  		
	  </td>
	  <td>
	  		${service_map.config_file}
	  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#saveModal" data-service-name="${service_map.name}" data-config_file="${service_map.config_file}">수정</button>
	  </td>
	  <td>
	  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#copyModal" data-service-name="${service_map.name}" data-config_file="${service_map.config_file}">복사</button>
	  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#removeModal" data-service-name="${service_map.name}">삭제</button>
	  		
	  </td>
	  <td>${fn:length(service_map.httpd_hosts)}</td>
	  <td>${fn:length(service_map.jboss_hosts)}</td>
	  <td></td>
  </tr>
  		
  </c:forEach>
  
  <tr>
	  <td colspan=5>
	  	
	  	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newModal">Service 추가</button>
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


<!-- 서비스 복사 Modal -->
<div class="modal fade" id="copyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
      </div>
      <div class="modal-body">
        <form name="copy_service_form" method="post" action="${pageContext.request.contextPath}/project/copy_service.do">
          <div class="form-group">
            <label for="name" class="control-label">Service Name:</label>
            <input name="name" type="text" class="form-control" id="name" value="">
            <input name="copy_src_name" type="hidden" class="form-control" id="name" value="">
          </div>
          <div class="form-group">
            <label for="config_file" class="control-label">Config File:</label>
            <input name="config_file" type="text" class="form-control" id="config_file" value="">
          </div>
         </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:copy_service();">저장</button>
      </div>
    </div>
  </div>
</div>

<!-- 서비스 복사 Modal 끝 -->

<!-- 신규서비스 추가 Modal -->
<div class="modal fade" id="newModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">Service 추가</h4>
      </div>
      <div class="modal-body">
      
        <form name="add_service_form" method="post" action="${pageContext.request.contextPath}/project/add_service.do">
          <div class="form-group">
            <label for="name" class="control-label">Service Name:</label>
            <input name="name" type="text" class="form-control" id="name" value="">
          </div>
          <div class="form-group">
            <label for="config_file" class="control-label">Config File:</label>
            <input name="config_file" type="text" class="form-control" id="config_file" value="">
          </div>
         </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:add_service();">저장</button>
      </div>
    </div>
  </div>
</div>
<!-- 신규서비스 Modal End-->

<!-- 삭제  set up the modal to start hidden and fade in and out -->
<div id="removeModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- dialog body -->
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
        <form name="remove_service_form" method="post" action="${pageContext.request.contextPath}/project/remove_service.do">
        	<input name="name" type="hidden" class="form-control" id="name" value="">
        </form>
      </div>
      <!-- dialog buttons -->
       <div class="modal-footer">
      		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      		<button type="button" class="btn btn-primary" onClick="javascript:remove_service();">OK</button>
      	</div>
    </div>
  </div>
</div>

<!-- 수정 -->
<div class="modal fade" id="saveModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">Service 수정</h4>
      </div>
      <div class="modal-body">
      
        <form name="save_service_form" method="post" action="${pageContext.request.contextPath}/project/save_service.do">
          <div class="form-group">
            <label for="name" class="control-label">Service Name:</label>
            <input name="name" type="text" class="form-control" id="name" value="">
            <input name="save_src_name" type="hidden" class="form-control" id="name" value="">
          </div>
          <div class="form-group">
            <label for="config_file" class="control-label">Config File:</label>
            <input name="config_file" type="text" class="form-control" id="config_file" value="">
          </div>
         </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:save_service();">저장</button>
      </div>
    </div>
  </div>
</div>


<script type="text/javascript">
//삭제시 서비스명 표시, 입력
$('#removeModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var name = button.data('service-name') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Service ' + name + '을 삭제합니다.')
	  modal.find('.modal-body #name').val(name)
	})
	
//복사 서비스명 표시, 입력
$('#copyModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var name = button.data('service-name') // Extract info from data-* attributes
	  var config_file = button.data('config_file') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Service ' + name + '을 복사합니다.')
	  modal.find('.modal-body #name').val(name)
	  modal.find('.modal-body #copy_src_name').val(name)
	  modal.find('.modal-body #config_file').val(config_file)
	})

//수정 서비스명 표시, 입력
$('#saveModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var name = button.data('service-name') // Extract info from data-* attributes
	  var config_file = button.data('config_file') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Service ' + name + '을 수정합니다.')
	  modal.find('.modal-body #name').val(name)
	  modal.find('.modal-body #save_src_name').val(name)
	  modal.find('.modal-body #config_file').val(config_file)
	})
</script>