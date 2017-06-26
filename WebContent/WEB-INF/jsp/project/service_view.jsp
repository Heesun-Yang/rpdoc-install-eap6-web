<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="java.util.*" %>
<%@ page import="com.rp.project.ProjectSvc" %>
<%@ page import="org.slf4j.Logger" %>
<%@ page import="org.slf4j.LoggerFactory" %>
<%!
 static Logger logger = LoggerFactory.getLogger("jsp"); //log4j를 위해 
%>

<%
	
	// Sample Httpd Host로 부터 config key값을 받아 자바스크립트 생성
	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
	
	HashMap<String, Object> sample_httpd_host = (HashMap<String, Object>) projectSvc.getSampleHttpdHost();
	HashMap<String, Object> sample_httpd_config = (HashMap<String, Object>) sample_httpd_host.get("config");
	
	HashMap<String, Object> sample_httpd_config_mpm = (HashMap<String, Object>) sample_httpd_config.get("mpm");
	
	ArrayList<Object> sample_httpd_config_vhosts = (ArrayList<Object>) sample_httpd_config.get("vhosts");
	HashMap<String, Object> sample_httpd_config_ssl= (HashMap<String, Object>) sample_httpd_config.get("ssl");
	HashMap<String, Object> sample_httpd_config_connector = (HashMap<String, Object>) sample_httpd_config.get("connector");
	
	HashMap<String, Object> mod_jk = (HashMap<String, Object>)sample_httpd_config_connector.get("mod_jk");
	
	HashMap<String, Object> mod_cluster = (HashMap<String, Object>)sample_httpd_config_connector.get("mod_cluster");
	
%>

<jsp:include page="/WEB-INF/jsp/inc/header.jsp"></jsp:include>

<jsp:include page="/WEB-INF/jsp/inc/top.jsp"></jsp:include>

    <div class="container-fluid">
      <div class="row">
        <jsp:include page="/WEB-INF/jsp/inc/left.jsp">
        	<jsp:param name="left_menu" value="service" />
        </jsp:include>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
        <!-- service Name -->
        <h2 class="sub-header"><a href="get_service_list.do?left_menu=instance_default"><span class="glyphicon glyphicon-arrow-left"></span> Service List</a></h2>
        <h2 class="sub-header"><span class="glyphicon glyphicon-triangle-bottom"></span> ${service.name}</h2>
          <div class="table-responsive">


<!-- Main page -->



<script type="text/javascript">
	function add_httpd_host(){
		var frm=document.add_httpd_host_form;
		frm.submit();
	}
	function copy_httpd_host(){
		var frm=document.copy_httpd_host_form;
		frm.submit();
	}
	function save_httpd_host(){
		var frm=document.httpd_host_form;
		frm.submit();
	}
	function save_httpd_main_config(){
		var frm=document.save_httpd_main_config_form;
		frm.submit();
	}
	function save_httpd_config_mpm(){
		var frm=document.save_httpd_config_mpm_form;
		frm.submit();
	}
	function save_httpd_config_connector(){
		var frm=document.save_httpd_config_connector_form;
		frm.submit();
	}
	function save_httpd_config_ssl(){
		var frm=document.save_httpd_config_ssl_form;
		frm.submit();
	}
	function remove_httpd_host(){
		var frm=document.remove_httpd_host_form;
		frm.submit();
	}
	function save_jboss_host(){
		var frm=document.save_jboss_host_form;
		frm.submit();
	}
	function add_jboss_host(){
		var frm=document.add_jboss_host_form;
		frm.submit();
	}
	function copy_jboss_host(){
		var frm=document.copy_jboss_host_form;
		frm.submit();
	}
	function remove_jboss_host(){
		var frm=document.remove_jboss_host_form;
		frm.submit();
	}
	function add_jboss_instance(){
		var frm=document.add_jboss_instance_form;
		frm.submit();
	}
	function save_jboss_instance(){
		var frm=document.save_jboss_instance_form;
		frm.submit();
	}
	function copy_jboss_instance(){
		var frm=document.copy_jboss_instance_form;
		frm.submit();
	}
	function remove_jboss_instance(){
		var frm=document.remove_jboss_instance_form;
		frm.submit();
	}
	
	function show_mod_cluster(){
		$('#mod_cluster_group').show();
		$('#mod_jk_group').hide();
	}
	function show_mod_jk(){
		$('#mod_jk_group').show();
		$('#mod_cluster_group').hide();
		
	}
	
</script>


<form name="detail_form" method="post" action="edit_service.do">

<h3>Web </h3>	
<table class="table table-striped">
	<thead>
		<tr>
			<th width="20%">Host IP</th>
			<th width="20%">Host Action</th>
			<th width="40%">Config</th>
		</tr>
  	</thead>
  <c:forEach var="httpd_host" items="${service.httpd_hosts}" varStatus="status">
  <tr>
	  <td>
	  		<b>${httpd_host.ip}</b> 
	  		
	  </td>
	  <td>
	  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#saveHttpdHostModal" 
	  			data-ip="${httpd_host.ip}" 
	  			data-os_user_id="${httpd_host.os_user_id}"
	  			data-os_user_pw="${httpd_host.os_user_pw}"
	  			data-httpd_home="${httpd_host.httpd_home}"
	  			>
	  		수정
	  		</button>
	  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#copyHttpdHostModal" data-ip="${httpd_host.ip}">복사</button>
	  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#removeHttpdHostModal" data-ip="${httpd_host.ip}">삭제</button>
	  </td>
	  <td>
	  
	  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#saveHttpdMainConfigModal"
	  			data-ip="${httpd_host.ip}"
	  			<c:forEach var="entry" items="${httpd_host.config}" varStatus="status">
	  				<c:if test="${entry.value.getClass().name=='java.lang.String'}">
	  				data-${fn:toLowerCase(entry.key)}="${entry.value}"
	  				</c:if>
	  			</c:forEach>
	  		>Main Config</button>
	  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#saveHttpdConfigMpmModal"
	  			data-ip="${httpd_host.ip}"
	  			<c:forEach var="entry" items="${httpd_host.config.mpm}" varStatus="status">
	  				<c:if test="${entry.value.getClass().name=='java.lang.String'}">
	  				data-${fn:toLowerCase(entry.key)}="${entry.value}"
	  				</c:if>
	  			</c:forEach>
	  		>MPM</button>
	  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#saveHttpdConfigConnectorModal" 
	  			data-ip="${httpd_host.ip}"
	  			data-use_connector="${httpd_host.config.connector.use_connector}"
	  			<c:forEach var="entry" items="${httpd_host.config.connector.mod_jk}" varStatus="status">
	  				<c:if test="${entry.value.getClass().name=='java.lang.String'}">
	  				data-${fn:toLowerCase(entry.key)}="${entry.value}"
	  				</c:if>
	  			</c:forEach>
	  			data-jkmounts="${httpd_host.config.connector.mod_jk.JkMounts.toString()}"
	  			
	  			<c:forEach var="entry" items="${httpd_host.config.connector.mod_cluster}" varStatus="status">
	  				<c:if test="${entry.value.getClass().name=='java.lang.String'}">
	  				data-${fn:toLowerCase(entry.key)}="${entry.value}"
	  				</c:if>
	  			</c:forEach>
	  		>Connector</button>
	  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#saveHttpdConfigSslModal" 
	  			data-ip="${httpd_host.ip}"
	  			<c:forEach var="entry" items="${httpd_host.config.ssl}" varStatus="status">
	  				<c:if test="${entry.value.getClass().name=='java.lang.String'}">
	  				data-${fn:toLowerCase(entry.key)}="${entry.value}"
	  				</c:if>
	  			</c:forEach>
	  		>SSL</button>
	  
	  </td>
  </tr>
  		
  </c:forEach>
  
</table>
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addHttpdHostModal">Web Host 추가</button>

<br>
<br>
<br>

<h3>JBoss 	</h3>
<table class="table table-hover">
	<thead>
		<tr>
			<th width="20%">Host IP</th>
			<th width="20%">Host Action</th>
			<th width="20%">Instance명</th>
			<th width="20%">Port-Offset</th>
			<th width="20%">Instance Action</th>
 		</tr>
  	</thead>
  <c:forEach var="jboss_host" items="${service.jboss_hosts}" varStatus="status">
  <tr>
	  <td>
	  		<b>${jboss_host.ip}</b>
	  		
	  		
	  </td>
	  <td>
	  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#saveJbossHostModal" 
	  			data-ip="${jboss_host.ip}" 
	  			
	  			data-os_user_id="${jboss_host.os_user_id}"
	  			data-os_user_pw="${jboss_host.os_user_pw}"
	  			data-java_home="${jboss_host.java_home}"
	  			data-jboss_home="${jboss_host.jboss_home}"
	  			data-domain_base="${jboss_host.domain_base}"
	  			>
	  		수정
	  		</button>
	  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#copyJbossHostModal" data-ip="${jboss_host.ip}">복사</button>
	  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#removeJbossHostModal" data-ip="${jboss_host.ip}">삭제</button>
	  </td>
	  <td></td>
	  <td></td>
	  <td></td>
  </tr>
  
	  <c:forEach var="instance" items="${jboss_host.instances}" varStatus="status">
	  <tr>
		  <td></td>
		  <td></td>
		  <td>
		  		${instance.instance_name}
		  </td>
		  <td>
		  		${instance.port_offset}
		  </td>
		  <td>
		  	<%-- data에 colon 이 있을 경우 javascript가 작동안하므로 제거 --%>
	  		<%-- data 첫번째 이후에 대소문자가 섞여있을 경우 javascript가 작동안하므로 제거 --%>
		  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#saveJbossInstanceModal"
		  			data-ip="${jboss_host.ip}" 
		  	<c:forEach var="entry" items="${instance}" varStatus="status">
 				<c:choose>
	  				<c:when test="${entry.key == '-XX:PermSize'}">
						data-permsize="${entry.value}" 
					</c:when>
					<c:when test="${entry.key == '-XX:MaxPermSize'}">
						data-maxpermsize="${entry.value}" 
					</c:when>
					<c:when test="${entry.key == '-XX:HeapDumpPath'}">
						data-heapdumppath="${entry.value}" 
					</c:when>
					<c:when test="${entry.key == '-Djboss.default.jgroups.stack'}">
						data-${fn:replace(entry.key, ".", "_")}="${entry.value}" 
					</c:when>
					<c:otherwise>data-${entry.key}="${entry.value}"</c:otherwise>
				</c:choose>
				
	       </c:forEach>
		  		>수정
		  		</button>
		  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#copyJbossInstanceModal"
		  			data-ip="${jboss_host.ip}" 
		  			data-instance_name="${instance.instance_name}" 
		  		>복사
		  		</button>
		  		<button type="button" class="btn btn-default" data-toggle="modal" data-target="#removeJbossInstanceModal"
		  			data-ip="${jboss_host.ip}" 
		  			data-instance_name="${instance.instance_name}" 
		  		>삭제</button>
		  		
		  </td>
		  
	  </tr>
	  		
	  </c:forEach>
	  
	  <tr>
		  <td></td>
		  <td></td>
		  <td>
		  		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addJbossInstanceModal">Instance 추가</button>
		  </td>
		  <td>
		  		
		  </td>
		  <td>
		  		
		  </td>
	  </tr>
  		
  </c:forEach>
  
</table>
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addJbossHostModal">JBoss Host 추가</button>


</form>

<!-- Main page end -->
	
	
          </div>
        </div>
      </div>
    </div>
<jsp:include page="/WEB-INF/jsp/inc/footer.jsp"></jsp:include>


<!-- Modal -->

<!-- saveHttpdHostModal -->
<div class="modal fade" id="saveHttpdHostModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
      </div>
      <div class="modal-body">
        <form name="httpd_host_form" method="post" action="${pageContext.request.contextPath}/project/save_httpd_host.do">
          <div class="form-group">
            <label for=ip class="control-label">Host IP:</label>
            <input name="ip" type="text" class="form-control" id="ip" value="">
          </div>
          <div class="form-group">
            <label for="os_user_id" class="control-label">OS User ID:</label>
            <input name="os_user_id" type="text" class="form-control" id="os_user_id" value="">
          </div>
          <div class="form-group">
            <label for="os_user_pw" class="control-label">OS User PW:</label>
            <input name="os_user_pw" type="text" class="form-control" id="os_user_pw" value="">
          </div>
          <div class="form-group">
            <label for="httpd_home" class="control-label">HTTPD HOME:</label>
            <input name="httpd_home" type="text" class="form-control" id="httpd_home" value="">
          </div>
          
         	
          <input name="service_name" type="hidden" class="form-control" id="service_name" value="">
          <input name="org_ip" type="hidden" class="form-control" id="org_ip" value="">
          <!-- 
          <div class="form-group">
            <label for="message-text" class="control-label">Message:</label>
            <textarea class="form-control" id="message-text"></textarea>
          </div>
           -->
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:save_httpd_host();">저장</button>
      </div>
    </div>
  </div>
</div>

<!-- addHttpdHostModal -->
<div class="modal fade" id="addHttpdHostModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
      </div>
      <div class="modal-body">
        <form name="add_httpd_host_form" method="post" action="${pageContext.request.contextPath}/project/add_httpd_host.do">
          <div class="form-group">
            <label for=ip class="control-label">Host IP:</label>
            <input name="ip" type="text" class="form-control" id="ip" value="">
          </div>
          <div class="form-group">
            <label for="os_user_id" class="control-label">OS User ID:</label>
            <input name="os_user_id" type="text" class="form-control" id="os_user_id" value="">
          </div>
          <div class="form-group">
            <label for="os_user_pw" class="control-label">OS User PW:</label>
            <input name="os_user_pw" type="text" class="form-control" id="os_user_pw" value="">
          </div>
          <div class="form-group">
            <label for="httpd_home" class="control-label">HTTPD HOME:</label>
            <input name="httpd_home" type="text" class="form-control" id="httpd_home" value="">
          </div>
          
         	
          <input name="service_name" type="hidden" class="form-control" id="service_name" value="">
          
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:add_httpd_host();">저장</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="copyHttpdHostModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
      </div>
      <div class="modal-body">
        <form name="copy_httpd_host_form" method="post" action="${pageContext.request.contextPath}/project/copy_httpd_host.do">
          <div class="form-group">
            <label for=ip class="control-label">Host IP:</label>
            <input name="ip" type="text" class="form-control" id="ip" value="">
          </div>
          
          <input name="copy_org_ip" type="hidden" class="form-control" id="copy_org_ip" value="">
          <input name="service_name" type="hidden" class="form-control" id="service_name" value="">
          
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:copy_httpd_host();">저장</button>
      </div>
    </div>
  </div>
</div>

<!-- 삭제  set up the modal to start hidden and fade in and out -->
<div id="removeHttpdHostModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- dialog body -->
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
        <form name="remove_httpd_host_form" method="post" action="${pageContext.request.contextPath}/project/remove_httpd_host.do">
        	<input name="service_name" type="hidden" class="form-control" id="service_name" value="">
        	<input name="ip" type="hidden" class="form-control" id="ip" value="">
        </form>
      </div>
      <!-- dialog buttons -->
       <div class="modal-footer">
      		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      		<button type="button" class="btn btn-primary" onClick="javascript:remove_httpd_host();">삭제</button>
      	</div>
    </div>
  </div>
</div>


<div class="modal fade" id="saveHttpdMainConfigModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
      </div>
      <div class="modal-body">
        <form name="save_httpd_main_config_form" method="post" action="${pageContext.request.contextPath}/project/save_httpd_main_config.do">
        
        	<div class="form-group">
            <label for=timeout class="control-label">Timeout:</label>
            <input name="Timeout" type="number" class="form-control" id="timeout" value="" pattern="^[0-9]{1,}$">
          </div>
          <div class="form-group">
            <label for=keepalive class="control-label">KeepAlive:</label>
            <select name="KeepAlive" class="selectpicker form-control" id="keepalive">
			        <option value="On">Yes</option>
			        <option value="Off">No</option>
			  </select>
          </div>
          <div class="form-group">
            <label for=maxkeepaliverequests class="control-label">MaxKeepAliveRequests:</label>
            <input name="MaxKeepAliveRequests" type="number" class="form-control" id="maxkeepaliverequests" value="">
          </div>
          <div class="form-group">
            <label for=keepalivetimeout class="control-label">KeepAliveTimeout:</label>
            <input name="KeepAliveTimeout" type="number" class="form-control" id="keepalivetimeout" value="">
          </div>
          <div class="form-group">
            <label for=listen class="control-label">Listen:</label>
            <input name="Listen" type="text" class="form-control" id="listen" value="">
          </div>
          <div class="form-group">
            <label for=user class="control-label">User:</label>
            <input name="User" type="text" class="form-control" id="user" value="">
          </div>
          <div class="form-group">
            <label for=Group class="control-label">Group:</label>
            <input name="Group" type="text" class="form-control" id="group" value="">
          </div>
          <div class="form-group">
            <label for=servername class="control-label">ServerName:</label>
            <input name="ServerName" type="text" class="form-control" id="servername" value="">
          </div>
          <div class="form-group">
            <label for=documentroot class="control-label">DocumentRoot:</label>
            <input name="DocumentRoot" type="text" class="form-control" id="documentroot" value="">
          </div>
          <div class="form-group">
            <label for=loglevel class="control-label">LogLevel:</label>
            <select name="LogLevel" class="selectpicker form-control" id="loglevel">
			        <option value="emerg">emerg</option>
			        <option value="crit">crit</option>
			        <option value="error">error</option>
			        <option value="warn">warn</option>
			        <option value="notice">notice</option>
			        <option value="info">info</option>
			        <option value="debug">debug</option>
			  </select>
          </div>
          <div class="form-group">
            <label for=servertokens class="control-label">ServerTokens:</label>
            <select name="ServerTokens" class="selectpicker form-control" id="servertokens">
			        <option value="Prod">Prod</option>
			        <option value="Major">Major</option>
			        <option value="Minor">Minor</option>
			        <option value="Min">Min</option>
			        <option value="OS">OS</option>
			        <option value="Full">Full</option>
			  </select>
          </div>
          <div class="form-group">
            <label for=traceenable class="control-label">TraceEnable:</label>
            <select name="TraceEnable" class="selectpicker form-control" id="traceenable">
			        <option value="on">On</option>
			        <option value="off">Off</option>
			        <option value="extended">Extended</option>
			  </select>
          </div>
          <div class="form-group">
            <label for=customlog class="control-label">CustomLog:</label>
            <input name="CustomLog" type="text" class="form-control" id="customlog" value="">
          </div>


         <input name="service_name" type="hidden" class="form-control" id="service_name" value="">
          <input name="ip" type="hidden" class="form-control" id="ip" value="">
          
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:save_httpd_main_config();">저장</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="saveHttpdConfigMpmModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
      </div>
      <div class="modal-body">
        <form name="save_httpd_config_mpm_form" method="post" action="${pageContext.request.contextPath}/project/save_httpd_config_mpm.do">
		
			<div class="form-group">
            <label for=type class="control-label">type:</label>
            <select name="type" class="selectpicker form-control" id="type">
			        <option value="worker">Worker</option>
			        <option value="prefork">Prefork</option>
			        <option value="event">Event</option>
			     </select>
          </div>

			<div class="form-group">
            <label for=threadlimit class="control-label">ThreadLimit:</label>
            <input name="ThreadLimit" type="number" class="form-control" id="threadlimit" value=""> 
          </div>

			<div class="form-group">
            <label for=serverlimit class="control-label">ServerLimit:</label>
            <input name="ServerLimit" type="number" class="form-control" id="serverlimit" value=""> 
          </div>

			<div class="form-group">
            <label for=startservers class="control-label">StartServers:</label>
            <input name="StartServers" type="number" class="form-control" id="startservers" value=""> 
          </div>

			<div class="form-group">
            <label for=maxrequestworkers class="control-label">MaxRequestWorkers:</label>
            <input name="MaxRequestWorkers" type="number" class="form-control" id="maxrequestworkers" value=""> 
          </div>

			<div class="form-group">
            <label for=maxclients class="control-label">MaxClients:</label>
            <input name="MaxClients" type="text" class="form-control" id="maxclients" value=""> 
          </div>

			<div class="form-group">
            <label for=minsparethreads class="control-label">MinSpareThreads:</label>
            <input name="MinSpareThreads" type="number" class="form-control" id="minsparethreads" value=""> 
          </div>

			<div class="form-group">
            <label for=maxsparethreads class="control-label">MaxSpareThreads:</label>
            <input name="MaxSpareThreads" type="number" class="form-control" id="maxsparethreads" value=""> 
          </div>

			<div class="form-group">
            <label for=threadsperchild class="control-label">ThreadsPerChild:</label>
            <input name="ThreadsPerChild" type="text" class="form-control" id="threadsperchild" value=""> 
          </div>

			<div class="form-group">
            <label for=maxconnectionsperchild class="control-label">MaxConnectionsPerChild:</label>
            <input name="MaxConnectionsPerChild" type="number" class="form-control" id="maxconnectionsperchild" value=""> 
          </div>

			<div class="form-group">
            <label for=maxrequestsperchild class="control-label">MaxRequestsPerChild:</label>
            <input name="MaxRequestsPerChild" type="number" class="form-control" id="maxrequestsperchild" value=""> 
          </div>
          
         <input name="service_name" type="hidden" class="form-control" id="service_name" value="">
         <input name="ip" type="hidden" class="form-control" id="ip" value="">
          
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:save_httpd_config_mpm();">저장</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="saveHttpdConfigConnectorModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
      </div>
      <div class="modal-body">
        <form name="save_httpd_config_connector_form" method="post" action="${pageContext.request.contextPath}/project/save_httpd_config_connector.do">
        	<div class="form-group">
	        	<label for=use_connector class="control-label">Connector:</label>
	        	<label class="radio-inline">
			      <input type="radio" name="use_connector" id="use_connector1" onclick="javascript:show_mod_jk()" value="mod_jk">mod_jk
			    </label>
			    <label class="radio-inline">
			      <input type="radio" name="use_connector" id="use_connector2" onclick="javascript:show_mod_cluster()" value="mod_cluster"> mod_cluster
			    </label>
		    </div>
		    
		    
		    <div class="form-group" id="mod_jk_group">
		    	<div class="form-group">
	            <label for=socket_timeout class="control-label">socket_timeout(sec):</label>
	            <input name="socket_timeout" type="number" class="form-control" id="socket_timeout" value=""> 
	          </div>
	          <div class="form-group">
	            <label for=reply_timeout class="control-label">reply_timeout(ms):</label>
	            <input name="reply_timeout" type="number" class="form-control" id="reply_timeout" value=""> 
	          </div>
	          <div class="form-group">
	            <label for=recovery_options class="control-label">recovery_options:</label>
	            <input name="recovery_options" type="number" class="form-control" id="recovery_options" value=""> 
	          </div>
	          <div class="form-group">
	            <label for=connection_pool_timeout class="control-label">connection_pool_timeout:</label>
	            <input name="connection_pool_timeout" type="number" class="form-control" id="connection_pool_timeout" value=""> 
	          </div>
	          <div class="form-group">
	            <label for=method class="control-label">method:</label>
	            <select name="method" class="selectpicker form-control show-tick" id="method">
			        <option value="request">Request</option>
			        <option value="session">Session</option>
			        <option value="next">Next</option>
			        <option value="traffic">Traffic</option>
			        <option value="busyness">Busyness</option>
			     </select>
	          </div>
					
	          <div class="form-group">
	            <label for=sticky_session class="control-label">sticky_session:</label>
	            <input name="sticky_session" type="text" class="form-control" id="sticky_session" value=""> 
	          </div>
	          <div class="form-group">
	          		<label for=jkmounts class="control-label">JkMounts:</label>
					<input name="JkMounts" type="text" class="form-control" id="jkmounts" value=""> 
	          </div>


			</div>

			<div class="form-group" id="mod_cluster_group">
<%
	for (String key : mod_cluster.keySet()){
		if (mod_cluster.get(key).getClass().getName() == "java.lang.String"){
			
%>
			<div class="form-group">
            <label for=<%=key.toLowerCase()%> class="control-label"><%=key%>:</label>
            <input name="<%=key%>" type="text" class="form-control" id="<%=key.toLowerCase()%>" value=""> 
          </div>
<%
		}
	}
%>
			</div>
			
         <input name="service_name" type="hidden" class="form-control" id="service_name" value="">
          <input name="ip" type="hidden" class="form-control" id="ip" value="">
          
          
          
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:save_httpd_config_connector();">저장</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="saveHttpdConfigSslModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
      </div>
      <div class="modal-body">
        <form name="save_httpd_config_ssl_form" method="post" action="${pageContext.request.contextPath}/project/save_httpd_config_ssl.do">
        	<div class="form-group">
            <label for=use_ssl class="control-label">SSL 사용여부:</label>
            <select name="use_ssl" class="selectpicker form-control" id="use_ssl">
			        <option value="yes">Yes</option>
			        <option value="no">No</option>
			  </select>
          </div>
          <div class="form-group">
            <label for=loglevel class="control-label">LogLevel:</label>
            <select name="LogLevel" class="selectpicker form-control" id="loglevel">
			        <option value="emerg">emerg</option>
			        <option value="crit">crit</option>
			        <option value="error">error</option>
			        <option value="warn">warn</option>
			        <option value="notice">notice</option>
			        <option value="info">info</option>
			        <option value="debug">debug</option>
			  </select>
          </div>
          <div class="form-group">
            <label for=listen class="control-label">Listen 포트:</label>
            <input name="Listen" type="text" class="form-control" id="listen" value=""> 
          </div>
          <div class="form-group">
            <label for=sslprotocol class="control-label">SSLProtocol:</label>
            <input name="SSLProtocol" type="text" class="form-control" id="sslprotocol" value=""> 
          </div>
          <div class="form-group">
            <label for=sslciphersuite class="control-label">SSLCipherSuite:</label>
            <input name="SSLCipherSuite" type="text" class="form-control" id="sslciphersuite" value=""> 
          </div>
          <div class="form-group">
            <label for=generate_self_signed_certificate class="control-label">Self 인증서 사용여부:</label>
            <select name="generate_self_signed_certificate" class="selectpicker form-control" id="generate_self_signed_certificate">
			        <option value="yes">Yes</option>
			        <option value="no">No</option>
			  </select>
          </div>
          <div class="form-group">
            <label for=sslcertificatefile class="control-label">SSLCertificateFile:</label>
            <input name="SSLCertificateFile" type="text" class="form-control" id="sslcertificatefile" value=""> 
          </div>
          <div class="form-group">
            <label for=sslcertificatekeyfile class="control-label">SSLCertificateKeyFile:</label>
            <input name="SSLCertificateKeyFile" type="text" class="form-control" id="sslcertificatekeyfile" value=""> 
          </div>
			
         <input name="service_name" type="hidden" class="form-control" id="service_name" value="">
         <input name="ip" type="hidden" class="form-control" id="ip" value="">
          
          
          
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:save_httpd_config_ssl();">저장</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="saveJbossHostModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
      </div>
      <div class="modal-body">
        <form name="save_jboss_host_form" method="post" action="${pageContext.request.contextPath}/project/save_jboss_host.do">
          <div class="form-group">
            <label for=ip class="control-label">Host IP:</label>
            <input name="ip" type="text" class="form-control" id="ip" value="">
          </div>
          <div class="form-group">
            <label for="os_user_id" class="control-label">OS User ID:</label>
            <input name="os_user_id" type="text" class="form-control" id="os_user_id" value="">
          </div>
          <div class="form-group">
            <label for="os_user_pw" class="control-label">OS User PW:</label>
            <input name="os_user_pw" type="text" class="form-control" id="os_user_pw" value="">
          </div>
          <div class="form-group">
            <label for="java_home" class="control-label">JAVA HOME:</label>
            <input name="java_home" type="text" class="form-control" id="java_home" value="">
          </div>
          <div class="form-group">
            <label for="jboss_home" class="control-label">JBOSS HOME:</label>
            <input name="jboss_home" type="text" class="form-control" id="jboss_home" value="">
          </div>
          <div class="form-group">
            <label for="domain_base" class="control-label">Domain Base:</label>
            <input name="domain_base" type="text" class="form-control" id="domain_base" value="">
          </div>
         	
          <input name="service_name" type="hidden" class="form-control" id="service_name" value="">
          <input name="org_ip" type="hidden" class="form-control" id="org_ip" value="">
          <!-- 
          <div class="form-group">
            <label for="message-text" class="control-label">Message:</label>
            <textarea class="form-control" id="message-text"></textarea>
          </div>
           -->
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:save_jboss_host();">저장</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="addJbossHostModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
      </div>
      <div class="modal-body">
        <form name="add_jboss_host_form" method="post" action="${pageContext.request.contextPath}/project/add_jboss_host.do">
          <div class="form-group">
            <label for=ip class="control-label">Host IP:</label>
            <input name="ip" type="text" class="form-control" id="ip" value="">
          </div>
          <div class="form-group">
            <label for="os_user_id" class="control-label">OS User ID:</label>
            <input name="os_user_id" type="text" class="form-control" id="os_user_id" value="">
          </div>
          <div class="form-group">
            <label for="os_user_pw" class="control-label">OS User PW:</label>
            <input name="os_user_pw" type="text" class="form-control" id="os_user_pw" value="">
          </div>
          <div class="form-group">
            <label for="java_home" class="control-label">JAVA HOME:</label>
            <input name="java_home" type="text" class="form-control" id="java_home" value="">
          </div>
          <div class="form-group">
            <label for="jboss_home" class="control-label">JBOSS HOME:</label>
            <input name="jboss_home" type="text" class="form-control" id="jboss_home" value="">
          </div>
          <div class="form-group">
            <label for="domain_base" class="control-label">Domain Base:</label>
            <input name="domain_base" type="text" class="form-control" id="domain_base" value="">
          </div>
         	
         	
          <input name="service_name" type="hidden" class="form-control" id="service_name" value="">
          
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:add_jboss_host();">저장</button>
      </div>
    </div>
  </div>
</div>

<!-- copyJbossHostModal -->
<div class="modal fade" id="copyJbossHostModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
      </div>
      <div class="modal-body">
        <form name="copy_jboss_host_form" method="post" action="${pageContext.request.contextPath}/project/copy_jboss_host.do">
          <div class="form-group">
            <label for=ip class="control-label">JBoss Host IP:</label>
            <input name="ip" type="text" class="form-control" id="ip" value="">
          </div>
          
          <input name="copy_org_ip" type="hidden" class="form-control" id="copy_org_ip" value="">
          <input name="service_name" type="hidden" class="form-control" id="service_name" value="">
          
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:copy_jboss_host();">저장</button>
      </div>
    </div>
  </div>
</div>

<!-- 삭제  set up the modal to start hidden and fade in and out -->
<div id="removeJbossHostModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- dialog body -->
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
        <form name="remove_jboss_host_form" method="post" action="${pageContext.request.contextPath}/project/remove_jboss_host.do">
        	<input name="service_name" type="hidden" class="form-control" id="service_name" value="">
        	<input name="ip" type="hidden" class="form-control" id="ip" value="">
        </form>
      </div>
      <!-- dialog buttons -->
       <div class="modal-footer">
      		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      		<button type="button" class="btn btn-primary" onClick="javascript:remove_jboss_host();">삭제</button>
      	</div>
    </div>
  </div>
</div>

<!-- Add JBoss Instance -->
<div class="modal fade" id="addJbossInstanceModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
      </div>
      <div class="modal-body">
        <form name="add_jboss_instance_form" method="post" action="${pageContext.request.contextPath}/project/add_jboss_instance.do">
        	
          <div class="form-group">
            <label for=instance_name class="control-label">Instance명:</label>
            <input name="instance_name" type="text" class="form-control" id="instance_name" value="">
          </div>
          <div class="form-group">
            <label for="port_offset" class="control-label">Port-Offset:</label>
            <input name="port_offset" type="text" class="form-control" id="port_offset" value="">
          </div>
          
          <!-- Hidden -->	
          <input name="service_name" type="hidden" class="form-control" id="service_name" value="">
          <input name="ip" type="hidden" class="form-control" id="ip" value="">
          
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:add_jboss_instance();">저장</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="saveJbossInstanceModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
      </div>
      <div class="modal-body">
        <form name="save_jboss_instance_form" method="post" action="${pageContext.request.contextPath}/project/save_jboss_instance.do">
        
        	<div class="form-group">
	            <label for=instance_name class="control-label">Instance 명:</label>
	            <input name="instance_name" type="text" class="form-control" id="instance_name" value="">
          </div>
          <div class="form-group">
          <%-- 
        	<c:forEach var="entry" items="${project.instance_default_values}" varStatus="status">
	            <label for="${entry.key}" class="control-label">${entry.key}:</label>
	            <input name="${entry.key}" type="text" class="form-control" id="${entry.key}" value="">
	       </c:forEach>
	        --%>
	        	
	       	 <label for="config_file" class="control-label">config_file:</label>
	            <input name="config_file" type="text" class="form-control" id="config_file" value="">
	       	
	            <label for="log_home" class="control-label">log_home:</label>
	            <input name="log_home" type="text" class="form-control" id="log_home" value="">
	       
	            <label for="node_name" class="control-label">node_name:</label>
	            <input name="node_name" type="text" class="form-control" id="node_name" value="">
	       
	            <label for="bind_addr" class="control-label">bind_addr:</label>
	            <input name="bind_addr" type="text" class="form-control" id="bind_addr" value="">
	       
	            <label for="jgroups_bind_addr" class="control-label">jgroups_bind_addr:</label>
	            <input name="jgroups_bind_addr" type="text" class="form-control" id="jgroups_bind_addr" value="">
	       
	            <label for="port_offset" class="control-label">port_offset:</label>
	            <input name="port_offset" type="text" class="form-control" id="port_offset" value="">
	       
	            <label for="mgmt_addr" class="control-label">mgmt_addr:</label>
	            <input name="mgmt_addr" type="text" class="form-control" id="mgmt_addr" value="">
	       
	            <label for="controller_ip" class="control-label">controller_ip:</label>
	            <input name="controller_ip" type="text" class="form-control" id="controller_ip" value="">
	       
	            <label for="multicast_addr" class="control-label">multicast_addr:</label>
	            <input name="multicast_addr" type="text" class="form-control" id="multicast_addr" value="">
	       
	            <label for="jms_multicast_addr" class="control-label">jms_multicast_addr:</label>
	            <input name="jms_multicast_addr" type="text" class="form-control" id="jms_multicast_addr" value="">
	       
	            <label for="modcluster_multicast_addr" class="control-label">modcluster_multicast_addr:</label>
	            <input name="modcluster_multicast_addr" type="text" class="form-control" id="modcluster_multicast_addr" value="">
	       
	            <label for="-Xms" class="control-label">-Xms:</label>
	            <input name="-Xms" type="text" class="form-control" id="-Xms" value="">
	       
	            <label for="-Xmx" class="control-label">-Xmx:</label>
	            <input name="-Xmx" type="text" class="form-control" id="-Xmx" value="">
	       
	            <label for="-XXPermSize" class="control-label">-XX:PermSize:</label>
	            <input name="-XX:PermSize" type="text" class="form-control" id="-XX_PermSize" value="">
	       
	            <label for="-XXMaxPermSize" class="control-label">-XX:MaxPermSize:</label>
	            <input name="-XX:MaxPermSize" type="text" class="form-control" id="-XX_MaxPermSize" value="">
	       
	            <label for="-Xss" class="control-label">-Xss:</label>
	            <input name="-Xss" type="text" class="form-control" id="-Xss" value="">
	       
	            <label for="gc_option" class="control-label">gc_option:</label>
	            <input name="gc_option" type="text" class="form-control" id="gc_option" value="">
	       
	            <label for="-Xloggc" class="control-label">-Xloggc:</label>
	            <input name="-Xloggc" type="text" class="form-control" id="-Xloggc" value="">
	       
	            <label for="-XXHeapDumpPath" class="control-label">-XX:HeapDumpPath:</label>
	            <input name="-XX:HeapDumpPath" type="text" class="form-control" id="-XX_HeapDumpPath" value="">
	       
	            <label for="-Djboss.default.jgroups.stack" class="control-label">-Djboss.default.jgroups.stack:</label>
	            <input name="-Djboss.default.jgroups.stack" type="text" class="form-control" id="-Djboss_default_jgroups_stack" value="">
	       
	            <label for="admin_console_id" class="control-label">admin_console_id:</label>
	            <input name="admin_console_id" type="text" class="form-control" id="admin_console_id" value="">
	       
	            <label for="admin_console_pw" class="control-label">admin_console_pw:</label>
	            <input name="admin_console_pw" type="text" class="form-control" id="admin_console_pw" value="">
	       
			</div>
         	
          <input name="service_name" type="hidden" class="form-control" id="service_name" value="">
          <input name="ip" type="hidden" class="form-control" id="ip" value="">
          <!-- 
          <div class="form-group">
            <label for="message-text" class="control-label">Message:</label>
            <textarea class="form-control" id="message-text"></textarea>
          </div>
           -->
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:save_jboss_instance();">저장</button>
      </div>
    </div>
  </div>
</div>

<!-- copyJbossInstanceModal -->
<div class="modal fade" id="copyJbossInstanceModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
      </div>
      <div class="modal-body">
        <form name="copy_jboss_instance_form" method="post" action="${pageContext.request.contextPath}/project/copy_jboss_instance.do">
          <div class="form-group">
            <label for=instance_name class="control-label">JBoss Instance Name:</label>
            <input name="instance_name" type="text" class="form-control" id="instance_name" value="">
          </div>
          <div class="form-group">
            <label for=port_offset class="control-label">Port Offset:</label>
            <input name="port_offset" type="number" class="form-control" id="port_offset" value="">
          </div>
          
          <input name="service_name" type="hidden" class="form-control" id="service_name" value="">
          <input name="copy_org_instance_name" type="hidden" class="form-control" id="copy_org_instance_name" value="">
          <input name="ip" type="hidden" class="form-control" id="ip" value="">
          
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:copy_jboss_instance();">저장</button>
      </div>
    </div>
  </div>
</div>

<!-- removeJbossInstanceModal -->
<div class="modal fade" id="removeJbossInstanceModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
      </div>
      <div class="modal-body">
        <form name="remove_jboss_instance_form" method="post" action="${pageContext.request.contextPath}/project/remove_jboss_instance.do">
          
          <input name="service_name" type="hidden" class="form-control" id="service_name" value="">
          <input name="instance_name" type="hidden" class="form-control" id="instance_name" value="">
          <input name="ip" type="hidden" class="form-control" id="ip" value="">
          
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="javascript:remove_jboss_instance();">삭제</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal End-->


<script type="text/javascript">

//Httpd Host 추가
$('#addHttpdHostModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  var os_user_id = button.data('os_user_id') // Extract info from data-* attributes
	  var os_user_pw = button.data('os_user_pw') // Extract info from data-* attributes
	  var httpd_home = button.data('httpd_home') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Httpd Host를 추가합니다.')
	  modal.find('.modal-body #ip').val(ip)
	  modal.find('.modal-body #os_user_id').val(os_user_id)
	  modal.find('.modal-body #os_user_pw').val(os_user_pw)
	  modal.find('.modal-body #httpd_home').val(httpd_home)
	  
	  modal.find('.modal-body #service_name').val("${service.name}")
	  
	})
//Httpd Host 복사
$('#copyHttpdHostModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Httpd Host ' + ip + '를 복사하여 새로운 HTTPD Host를 생성합니다.')
	  modal.find('.modal-body #ip').val(ip)
	  
	  modal.find('.modal-body #service_name').val("${service.name}")
	  modal.find('.modal-body #copy_org_ip').val(ip)
	  
})
	
//Httpd Host 수정 서비스명 표시, 입력
$('#saveHttpdHostModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  var os_user_id = button.data('os_user_id') // Extract info from data-* attributes
	  var os_user_pw = button.data('os_user_pw') // Extract info from data-* attributes
	  var httpd_home = button.data('httpd_home') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Httpd Host ' + ip + '을 수정합니다.')
	  modal.find('.modal-body #ip').val(ip)
	  modal.find('.modal-body #os_user_id').val(os_user_id)
	  modal.find('.modal-body #os_user_pw').val(os_user_pw)
	  modal.find('.modal-body #httpd_home').val(httpd_home)
	  
	  modal.find('.modal-body #service_name').val("${service.name}")
	  modal.find('.modal-body #org_ip').val(ip)
	})
	
//Httpd Host 삭제시 
$('#removeHttpdHostModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('HTTPD Host ' + ip + '을 삭제합니다.')
	  modal.find('.modal-body #service_name').val("${service.name}")
	  modal.find('.modal-body #ip').val(ip)
})

	
//Httpd Main config 수정 
$('#saveHttpdMainConfigModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  
  <%
  	
	for (String key : sample_httpd_config.keySet()){
		if (sample_httpd_config.get(key).getClass().getName() == "java.lang.String"){
			out.println(" var " + key.toLowerCase() + " = button.data('" + key.toLowerCase() + "')");
		}
		
	}
		 
  %>
  
	  var modal = $(this)
	  modal.find('.modal-title').text('Httpd Main Config를 수정합니다.')
	  
<%
	//Sample Httpd Host로 부터 config key값을 받아 자바스크립트 생성 
	for (String key : sample_httpd_config.keySet()){
		if (sample_httpd_config.get(key).getClass().getName() == "java.lang.String"){
%>
		modal.find('.modal-body #<%=key.toLowerCase()%>').val(<%=key.toLowerCase()%>)
<%
		}
	}
%>

	// Select Box 표시

	//저장된 keepalive가 선택되게 
	modal.find('.modal-body #keepalive option').filter(function(){
		    return $(this).val().toLowerCase() == keepalive
	}).prop('selected', true);
	modal.find('.modal-body #keepalive').selectpicker('refresh')

	//저장된 LogLevel가 선택되게 
	modal.find('.modal-body #loglevel option').filter(function(){
		    return $(this).val().toLowerCase() == loglevel
	}).prop('selected', true);
	modal.find('.modal-body #loglevel').selectpicker('refresh')

	//저장된 ServerTokens가 선택되게 
	modal.find('.modal-body #servertokens option').filter(function(){
		    return $(this).val().toLowerCase() == servertokens
	}).prop('selected', true);
	modal.find('.modal-body #servertokens').selectpicker('refresh')
	
	//저장된 TraceEnable가 선택되게 
	modal.find('.modal-body #traceenable option').filter(function(){
		    return $(this).val().toLowerCase() == traceenable
	}).prop('selected', true);
	modal.find('.modal-body #traceenable').selectpicker('refresh')


	  modal.find('.modal-body #service_name').val("${service.name}")
	  modal.find('.modal-body #ip').val(ip)
	  
	  
})


//Httpd MPM 수정 
$('#saveHttpdConfigMpmModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  
	  
	  
  <%
  	
	for (String key : sample_httpd_config_mpm.keySet()){
		if (sample_httpd_config_mpm.get(key).getClass().getName() == "java.lang.String"){
			out.println(" var " + key.toLowerCase() + " = button.data('" + key.toLowerCase() + "')");
		}
		
	}
		 
  %>
  
	  var modal = $(this)
	  modal.find('.modal-title').text('Httpd Config MPM 을 수정합니다.')
	  
<%
	//Sample Httpd Host로 부터 config key값을 받아 자바스크립트 생성 
	for (String key : sample_httpd_config_mpm.keySet()){
		if (sample_httpd_config_mpm.get(key).getClass().getName() == "java.lang.String"){
%>
		modal.find('.modal-body #<%=key.toLowerCase()%>').val(<%=key.toLowerCase()%>)
<%
		}
	}
%>

		//저장된 use_ssl가 선택되게 
		modal.find('.modal-body #type option').filter(function(){
			    return $(this).val().toLowerCase() == type
		}).prop('selected', true);
		modal.find('.modal-body #type').selectpicker('refresh')


	  modal.find('.modal-body #service_name').val("${service.name}")
	  modal.find('.modal-body #ip').val(ip)
	  
	  
})


//Httpd Connector 수정 
$('#saveHttpdConfigConnectorModal').on('show.bs.modal', function (event) {
	var button = $(event.relatedTarget) // Button that triggered the modal
	var ip = button.data('ip') // Extract info from data-* attributes
	
	var use_connector = button.data('use_connector')
	
	var jkmounts = button.data('jkmounts')
	
  <%
  	// mod_jk 세부항목 변수 정의
	for (String key : mod_jk.keySet()){
		if (mod_jk.get(key).getClass().getName() == "java.lang.String"){
			out.println(" var " + key.toLowerCase() + " = button.data('" + key.toLowerCase() + "')");
		}
	}
	// mod_cluster 세부항목 변수 정의
	for (String key : mod_cluster.keySet()){
		if (mod_cluster.get(key).getClass().getName() == "java.lang.String"){
			out.println(" var " + key.toLowerCase() + " = button.data('" + key.toLowerCase() + "')");
		}
	}
  %>
  
  
	  var modal = $(this)
	  modal.find('.modal-title').text('Httpd Connector 정보를 수정합니다.')
	  
	  
	  // Connector Type 선택
	  if (use_connector == "mod_jk"){
		  modal.find('.modal-body #use_connector1').prop("checked", true)
		  modal.find('.modal-body #mod_jk_group').show()
		  modal.find('.modal-body #mod_cluster_group').hide()
		  
	  } else {
		  modal.find('.modal-body #use_connector2').prop("checked", true)
		  modal.find('.modal-body #mod_cluster_group').show()
		  modal.find('.modal-body #mod_jk_group').hide()
	  }
	  
		// 저장된 Method가 선택되게 
	  	modal.find('.modal-body #method option').filter(function(){
		    return $(this).val().toLowerCase() == method
		}).prop('selected', true);
	  	modal.find('.modal-body #method').selectpicker('refresh')
		
	   
<%
	//Sample Httpd Host로 부터 mod_jk key값을 받아 자바스크립트 생성 
	for (String key : mod_jk.keySet()){
		if (mod_jk.get(key).getClass().getName() == "java.lang.String"){ 
%>
		modal.find('.modal-body #<%=key.toLowerCase()%>').val(<%=key.toLowerCase()%>)
<%
		}
	}
%>
	
		modal.find('.modal-body #jkmounts').val(jkmounts)

		
	<%
		//Sample Httpd Host로 부터 mod_cluster key값을 받아 자바스크립트 생성 
		for (String key : mod_cluster.keySet()){
			if (mod_cluster.get(key).getClass().getName() == "java.lang.String"){ 
	%>
			modal.find('.modal-body #<%=key.toLowerCase()%>').val(<%=key.toLowerCase()%>)
	<%
			}
		}
	%>
	
	  modal.find('.modal-body #service_name').val("${service.name}")
	  modal.find('.modal-body #ip').val(ip)
	  
	  
})

//Httpd ssl 수정 
$('#saveHttpdConfigSslModal').on('show.bs.modal', function (event) {
	var button = $(event.relatedTarget) // Button that triggered the modal
	var ip = button.data('ip') // Extract info from data-* attributes
	
	
  <%
  	// ssl 세부항목 변수 정의
	for (String key : sample_httpd_config_ssl.keySet()){
		if (sample_httpd_config_ssl.get(key).getClass().getName() == "java.lang.String"){
			out.println(" var " + key.toLowerCase() + " = button.data('" + key.toLowerCase() + "')");
		}
	}
	
  %>
  
  
	  var modal = $(this)
	  modal.find('.modal-title').text('Httpd SSL 정보를 수정합니다.')
	  
	  
<%
	//Sample Httpd Host로 부터 ssl key값을 받아 자바스크립트 생성 
	for (String key : sample_httpd_config_ssl.keySet()){
		if (sample_httpd_config_ssl.get(key).getClass().getName() == "java.lang.String"){ 
%>
		modal.find('.modal-body #<%=key.toLowerCase()%>').val(<%=key.toLowerCase()%>)
<%
		}
	}
%>
	
	//저장된 use_ssl가 선택되게 
	modal.find('.modal-body #use_ssl option').filter(function(){
		    return $(this).val().toLowerCase() == use_ssl
	}).prop('selected', true);
	modal.find('.modal-body #use_ssl').selectpicker('refresh')
	

	//저장된 LogLevel가 선택되게 
	modal.find('.modal-body #loglevel').filter(function(){
		return $(this).val().toLowerCase() == loglevel
	}).prop('selected', true);
	modal.find('.modal-body #loglevel').selectpicker('refresh')
	
	//저장된 generate_self_signed_certificate가 선택되게 
	modal.find('.modal-body #generate_self_signed_certificate option').filter(function(){
		    return $(this).val().toLowerCase() == generate_self_signed_certificate
	}).prop('selected', true);
	modal.find('.modal-body #generate_self_signed_certificate').selectpicker('refresh')
	
	
	  modal.find('.modal-body #service_name').val("${service.name}")
	  modal.find('.modal-body #ip').val(ip)
	  
	  
})
	
//Jboss Host 수정 서비스명 표시, 입력
$('#saveJbossHostModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  var os_user_id = button.data('os_user_id') // Extract info from data-* attributes
	  var os_user_pw = button.data('os_user_pw') // Extract info from data-* attributes
	  var java_home = button.data('java_home') // Extract info from data-* attributes
	  var jboss_home = button.data('jboss_home') // Extract info from data-* attributes
	  var domain_base = button.data('domain_base') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Jboss Host ' + ip + '을 수정합니다.')
	  modal.find('.modal-body #ip').val(ip)
	  modal.find('.modal-body #os_user_id').val(os_user_id)
	  modal.find('.modal-body #os_user_pw').val(os_user_pw)
	  modal.find('.modal-body #java_home').val(java_home)
	  modal.find('.modal-body #jboss_home').val(jboss_home)
	  modal.find('.modal-body #domain_base').val(domain_base)
	  
	  modal.find('.modal-body #service_name').val("${service.name}")
	  modal.find('.modal-body #org_ip').val(ip)
})
	
	
//Jboss Host 추가
$('#addJbossHostModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  var os_user_id = button.data('os_user_id') // Extract info from data-* attributes
	  var os_user_pw = button.data('os_user_pw') // Extract info from data-* attributes
	  var java_home = button.data('java_home') // Extract info from data-* attributes
	  var jboss_home = button.data('jboss_home') // Extract info from data-* attributes
	  var domain_base = button.data('domain_base') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Jboss Host를 추가합니다.')
	  modal.find('.modal-body #ip').val(ip)
	  modal.find('.modal-body #os_user_id').val(os_user_id)
	  modal.find('.modal-body #os_user_pw').val(os_user_pw)
	  modal.find('.modal-body #httpd_home').val(httpd_home)
	  modal.find('.modal-body #jboss_home').val(jboss_home)
	  modal.find('.modal-body #domain_base').val(domain_base)
	  
	  modal.find('.modal-body #service_name').val("${service.name}")
	  
	})
	
//Jboss Host 복사
$('#copyJbossHostModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('JBoss Host ' + ip + '를 복사하여 새로운 JBoss Host를 생성합니다.')
	  modal.find('.modal-body #ip').val(ip)
	  
	  modal.find('.modal-body #service_name').val("${service.name}")
	  modal.find('.modal-body #copy_org_ip').val(ip)
	  
})

//Httpd Host 삭제시 
$('#removeJbossHostModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('JBoss Host ' + ip + '을 삭제합니다.')
	  modal.find('.modal-body #service_name').val("${service.name}")
	  modal.find('.modal-body #ip').val(ip)
	})
//Jboss Instance 추가
$('#addJbossInstanceModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Jboss Instance를 추가합니다.')
	  modal.find('.modal-body #ip').val(ip)
	  
	  modal.find('.modal-body #service_name').val("${service.name}")
	  
})

//Jboss Instance 수정 
$('#saveJbossInstanceModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  
	  
	  var instance_name                = button.data('instance_name')
	  var config_file                  = button.data('config_file')
	  var log_home                     = button.data('log_home')
	  var node_name                    = button.data('node_name')
	  var bind_addr                    = button.data('bind_addr')
	  var jgroups_bind_addr            = button.data('jgroups_bind_addr')
	  var port_offset                  = button.data('port_offset')
	  var mgmt_addr                    = button.data('mgmt_addr')
	  var controller_ip                = button.data('controller_ip')
	  var multicast_addr               = button.data('multicast_addr')
	  var jms_multicast_addr           = button.data('jms_multicast_addr')
	  var modcluster_multicast_addr    = button.data('modcluster_multicast_addr')
	  var Xms                    	 	= button.data('-Xms') 
	  var Xmx                         	= button.data('-Xmx')
 	  var XXPermSize                 	= button.data('permsize')
	  var XXMaxPermSize              	= button.data('maxpermsize')
	  var Xss                         	= button.data('-Xss')
	  var gc_option                    = button.data('gc_option')
	  var Xloggc                      	= button.data('-Xloggc')
	  var XXHeapDumpPath             	= button.data('heapdumppath')
	  var jgroups_stack					= button.data('-Djboss_default_jgroups_stack')
	  var admin_console_id             = button.data('admin_console_id')
	  var admin_console_pw             = button.data('admin_console_pw') 

	  
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Jboss Instance ' + instance_name + '을 수정합니다.')
	  
	  modal.find('.modal-body #instance_name').val(instance_name)
		modal.find('.modal-body #config_file').val(config_file)
		modal.find('.modal-body #log_home').val(log_home)
		modal.find('.modal-body #node_name').val(node_name)
		modal.find('.modal-body #bind_addr').val(bind_addr)
		modal.find('.modal-body #jgroups_bind_addr').val(jgroups_bind_addr)
		modal.find('.modal-body #port_offset').val(port_offset)
		modal.find('.modal-body #mgmt_addr').val(mgmt_addr)
		modal.find('.modal-body #controller_ip').val(controller_ip)
		modal.find('.modal-body #multicast_addr').val(multicast_addr)
		modal.find('.modal-body #jms_multicast_addr').val(jms_multicast_addr)
		modal.find('.modal-body #modcluster_multicast_addr').val(modcluster_multicast_addr)
		modal.find('.modal-body #-Xms').val(Xms)
		modal.find('.modal-body #-Xmx').val(Xmx)
 		modal.find('.modal-body #-XX_PermSize').val(XXPermSize)
		modal.find('.modal-body #-XX_MaxPermSize').val(XXMaxPermSize)
		modal.find('.modal-body #-Xss').val(Xss)
		modal.find('.modal-body #gc_option').val(gc_option)
		modal.find('.modal-body #-Xloggc').val(Xloggc)
		modal.find('.modal-body #-XX_HeapDumpPath').val(XXHeapDumpPath)
		modal.find('.modal-body #-Djboss_default_jgroups_stack').val(jgroups_stack)
		modal.find('.modal-body #admin_console_id').val(admin_console_id)
		modal.find('.modal-body #admin_console_pw').val(admin_console_pw) 
	  
		
	  
	  modal.find('.modal-body #service_name').val("${service.name}")
	  modal.find('.modal-body #ip').val(ip)
	  
})
	
//Jboss Instance 복사
$('#copyJbossInstanceModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  var instance_name = button.data('instance_name') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('JBoss Instance ' + instance_name + '를 복사하여 새로운 JBoss Instance를 생성합니다.')
	  modal.find('.modal-body #instance_name').val(instance_name)
	  
	  modal.find('.modal-body #service_name').val("${service.name}")
	  modal.find('.modal-body #ip').val(ip)
	  modal.find('.modal-body #copy_org_instance_name').val(instance_name)
	  
})
	
//Jboss Instance 삭제
$('#removeJbossInstanceModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  var instance_name = button.data('instance_name') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('JBoss Instance ' + instance_name + '를 삭제합니다.')
	  modal.find('.modal-body #instance_name').val(instance_name)
	  
	  modal.find('.modal-body #service_name').val("${service.name}")
	  modal.find('.modal-body #ip').val(ip)
	  
	  
})

</script>