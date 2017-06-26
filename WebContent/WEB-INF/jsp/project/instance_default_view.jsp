<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="java.util.*" %>
<%@ page import="org.slf4j.Logger" %>
<%@ page import="org.slf4j.LoggerFactory" %>
<%@ page import="com.rp.project.ProjectSvc" %>
<%!
 static Logger logger = LoggerFactory.getLogger("jsp"); //log4j를 위해 
%>
<%
request.setAttribute("instance_default_values", ((HashMap<String,Object>)request.getSession().getAttribute("project")).get("instance_default_values"));
%>
<jsp:include page="/WEB-INF/jsp/inc/header.jsp"></jsp:include>

<jsp:include page="/WEB-INF/jsp/inc/top.jsp"></jsp:include>

    <div class="container-fluid">
      <div class="row">
        <jsp:include page="/WEB-INF/jsp/inc/left.jsp">
        	<jsp:param name="left_menu" value="instance_default" />
        </jsp:include>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
        <h2 class="sub-header">Jboss Instance 기본값</h2>
          <div class="table-responsive">


<!-- Main page -->
<script type="text/javascript">
	function save_instance_default(){
		var frm=document.save_instance_default_form;
		frm.submit();
	}
	
</script>

<form name="detail_form" method="post" action="edit_instance_default.do">
	
<table class="table table-striped">
  <tr>
	<th width="30%">구분</th>
	<th width="40%">입력값</th>
	<th width="30%">설명</th>
  </tr>
  <c:forEach var="entry" items="${instance_default_values}" varStatus="status">
  <tr>
	  <td>${entry.key}</td>
	  <td>${entry.value}</td>
	  <td></td>
  </tr>
  </c:forEach>
  
  
  <%-- 
  <tr>
	  <td>Config File</td>
	  <td>${project.instance_default_values.config_file}</td>
	  <td>설정파일 명</td>
  </tr>
  <tr>
	  <td>Log Home</td>
	  <td>${project.instance_default_values.log_home}</td>
	  <td>Log Home 경로</td>
  </tr>
  <tr>
	  <td>Server명</td>
	  <td>${project.instance_default_values.node_name}</td>
	  <td>JBoss Instance 명</td>
  </tr>
  <tr>
	  <td>Binding IP</td>
	  <td>${project.instance_default_values.bind_addr}</td>
	  <td>서비스 Binding IP</td>
  </tr>
  <tr>
	  <td>JGroups Binding IP</td>
	  <td>${project.instance_default_values.jgroups_bind_addr}</td>
	  <td>클러스터링 JGroups Binding IP</td>
  </tr>
  <tr>
	  <td>Port Offset</td>
	  <td>${project.instance_default_values.port_offset}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>Management IP</td>
	  <td>${project.instance_default_values.mgmt_addr}</td>
	  <td>Admin Console 접속 IP</td>
  </tr>
  <tr>
	  <td>Controller IP</td>
	  <td>${project.instance_default_values.controller_ip}</td>
	  <td>CLI 접속 IP</td>
  </tr>
  <tr>
	  <td>Multicast IP</td>
	  <td>${project.instance_default_values.multicast_addr}</td>
	  <td>JGroups Multicast IP</td>
  </tr>
  <tr>
	  <td>JMS Multicast IP</td>
	  <td>${project.instance_default_values.jms_multicast_addr}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>Modcluster Multicast IP</td>
	  <td>${project.instance_default_values.modcluster_multicast_addr}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>-Xms</td>
	  <td>${project.instance_default_values.-Xms}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>-Xmx</td>
	  <td>${project.instance_default_values.-Xmx}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>-XX:PermSize</td>
	  <td>${project.instance_default_values.-XX:PermSize}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>-XX:MaxPermSize</td>
	  <td>${project.instance_default_values.-XX:MaxPermSize}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>-Xss</td>
	  <td>${project.instance_default_values.-Xss}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>GC Option</td>
	  <td>${project.instance_default_values.gc_option}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>-Xloggc</td>
	  <td>${project.instance_default_values.-Xloggc}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>-XX:HeapDumpPath</td>
	  <td>${project.instance_default_values.-XX:HeapDumpPath}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>JGROUPS Default Stack</td>
	  <td>${project.instance_default_values.-Djboss.default.jgroups.stack}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>Admin Console Id</td>
	  <td>${project.instance_default_values.admin_console_id}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>Admin Console PW</td>
	  <td>${project.instance_default_values.admin_console_pw}</td>
	  <td></td>
  </tr>
   --%>
  <tr>
	  <td colspan=3>
	  	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#saveInstanceDefaultModal">수정</button>
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
<div id="saveInstanceDefaultModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- dialog body -->
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
        <form name="save_instance_default_form" method="post" action="${pageContext.request.contextPath}/project/save_instance_default.do">
 <%
	//Sample Httpd Host로 부터 config key값을 받아 자바스크립트 생성
	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
 	HashMap<String, Object> sampleProject = projectSvc.getProjectSample();
 	HashMap<String, Object> sampleInstanceDefaultValues = (HashMap<String, Object>)sampleProject.get("instance_default_values");
	
 	
 	
	for (String key : sampleInstanceDefaultValues.keySet()){
		if (sampleInstanceDefaultValues.get(key).getClass().getName() == "java.lang.String"){
			
%>
			<div class="form-group">
            <label for=<%=key.toLowerCase()%> class="control-label"><%=key%>:</label>
            <input name="<%=key%>" type="text" class="form-control" id="<%=key.toLowerCase().replace("-","").replace(":","").replace(".","")%>" value=""> 
          </div>
<%
		}
	}
%>
          
        </form>
      </div>
      <!-- dialog buttons -->
       <div class="modal-footer">
      		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      		<button type="button" class="btn btn-primary" onClick="javascript:save_instance_default();">수정</button>
      	</div>
    </div>
  </div>
</div>

<script type="text/javascript">
$('#saveInstanceDefaultModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  //var ip = button.data('ip') // Extract info from data-* attributes
	  
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Instance 기본값을 수정합니다.')
	  
	  
	<c:forEach var="entry" items="${instance_default_values}" varStatus="status">
		
		modal.find('.modal-body #${fn:replace(fn:replace(fn:replace(fn:toLowerCase(entry.key), "-", ""), ":",""),".","")}').val("${entry.value}")
	</c:forEach>
})
</script>