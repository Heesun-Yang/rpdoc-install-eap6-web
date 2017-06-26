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
        	<jsp:param name="left_menu" value="engineer" />
        </jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
        <h2 class="sub-header">Engineer</h2>
          <div class="table-responsive">


<!-- Main page -->


<script type="text/javascript">
	function save_engineer(){
		var frm=document.save_engineer_form;
		frm.submit();
	}
	
</script>

<form name="detail_form" method="post">
	
<table class="table table-striped">
  <tr>
	<th width="10%">구분</th>
	<th width="25%">입력값</th>
  </tr>
  <tr>
	  <td>엔지니어 명</td>
	  <td>${project.engineer.name}</td>
  </tr>
  <tr>
	  <td>전화번호</td>
	  <td>${project.engineer.tel_no}</td>
  </tr>
  <tr>
	  <td>E-Mail</td>
	  <td>${project.engineer.email}</td>
  </tr>
  
  <tr>
	  <td colspan=2>
	  	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#saveEngineerModal">수정</button>
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
<div id="saveEngineerModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- dialog body -->
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
        <form name="save_engineer_form" method="post" action="${pageContext.request.contextPath}/project/save_engineer.do">
        	<div class="form-group">
            <label for=name class="control-label">엔지니어 명:</label>
            <input name="name" type="text" class="form-control" id="name" value="">
          </div>
          <div class="form-group">
            <label for=tel_no class="control-label">전화번호:</label>
            <input name="tel_no" type="text" class="form-control" id="tel_no" value="">
          </div>
          <div class="form-group">
            <label for=email class="control-label">E-Mail:</label>
            <input name="email" type="text" class="form-control" id="email" value="">
          </div>
          
        </form>
      </div>
      <!-- dialog buttons -->
       <div class="modal-footer">
      		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      		<button type="button" class="btn btn-primary" onClick="javascript:save_engineer();">수정</button>
      	</div>
    </div>
  </div>
</div>

<script type="text/javascript">
$('#saveEngineerModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('엔지니어정보를 수정합니다.')
	  modal.find('.modal-body #name').val("${project.engineer.name}")
	  modal.find('.modal-body #tel_no').val("${project.engineer.tel_no}")
	  modal.find('.modal-body #email').val("${project.engineer.email}")
	  
})
</script>