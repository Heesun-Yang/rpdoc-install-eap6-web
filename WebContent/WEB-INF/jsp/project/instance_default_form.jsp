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
	function modify(){
		var frm=document.detail_form;
		frm.submit();
	}
	
</script>

<form name="detail_form" method="post" action="save_instance_default.do">
	
<table class="table table-striped">
  <tr>
	<th width="20%">구분</th>
	<th width="40%">입력값</th>
	<th width="40%">설명</th>
  </tr>
  <c:forEach var="entry" items="${instance_default_values}" varStatus="status">
  <tr>
	  <td>${entry.key}</td>
	  <td><input name="${entry.key}" value="${entry.value}" style="width: 400px;"></td>
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
