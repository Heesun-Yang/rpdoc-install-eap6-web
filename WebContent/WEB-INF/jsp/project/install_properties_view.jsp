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

<jsp:include page="/WEB-INF/jsp/inc/header.jsp"></jsp:include>

<jsp:include page="/WEB-INF/jsp/inc/top.jsp"></jsp:include>

    <div class="container-fluid">
      <div class="row">
        <jsp:include page="/WEB-INF/jsp/inc/left.jsp">
        	<jsp:param name="left_menu" value="install_properties" />
        </jsp:include>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
        <h2 class="sub-header">Install Properties</h2>
          <div class="table-responsive">


<!-- Main page -->
<script type="text/javascript">
	function save_install_properties_jdk(){
		var frm=document.save_install_properties_jdk_form;
		frm.submit();
	}
	function save_install_properties_jboss(){
		var frm=document.save_install_properties_jboss_form;
		frm.submit();
	}
	function save_install_properties_os_parameters(){
		var frm=document.save_install_properties_os_parameters_form;
		frm.submit();
	}
	function save_install_properties_web(){
		var frm=document.save_install_properties_web_form;
		frm.submit();
	}
	function save_install_properties_connector(){
		var frm=document.save_install_properties_connector_form;
		frm.submit();
	}
	function save_install_properties_etc(){
		var frm=document.save_install_properties_etc_form;
		frm.submit();
	}
</script>

<form name="detail_form" method="post">
<h3 class="sub-header">JDK</h3>
<table class="table table-striped">
  <tr>
	<th width="30%">구분</th>
	<th width="40%">입력값</th>
	<th width="30%">설명</th>
  </tr>
  <tr>
	  <td>jdk_file_name</td>
	  <td>${installProperties.jdk_file_name}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>install_jdk</td>
	  <td>${installProperties.install_jdk}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>use_root_user_for_jdk</td>
	  <td>${installProperties.use_root_user_for_jdk}</td>
	  <td></td>
  </tr>
  
  <tr>
	  <td colspan=3>
	  	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#saveJdkModal">수정</button>
	  </td>
	  
  </tr>
</table>

<br>
<h3 class="sub-header">JBoss</h3>
<table class="table table-striped">
  <tr>
	<th width="30%">구분</th>
	<th width="40%">입력값</th>
	<th width="30%">설명</th>
  </tr>
  <tr>
	  <td>install_eap</td>
	  <td>${installProperties.install_eap}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>install_eap_os_package</td>
	  <td>${installProperties.install_eap_os_package}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>jboss_eap_version</td>
	  <td>${installProperties.jboss_eap_version}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>jboss_engine_file_name</td>
	  <td>${installProperties.jboss_engine_file_name}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>ageout_history</td>
	  <td>${installProperties.ageout_history}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>jboss_engine_patch_file_name.0</td>
	  <td>${installProperties["jboss_engine_patch_file_name.0"]}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>jboss_engine_patch_file_name.1</td>
	  <td>${installProperties['jboss_engine_patch_file_name.1']}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>jboss_eap_native_file_name</td>
	  <td>${installProperties.jboss_eap_native_file_name}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>config_profile</td>
	  <td>${installProperties.config_profile}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>module_ext_file_name</td>
	  <td>${installProperties.module_ext_file_name}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>build_template_only</td>
	  <td>${installProperties.build_template_only}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>use_native_component</td>
	  <td>${installProperties.use_native_component}</td>
	  <td></td>
  </tr>
  <tr>
	  <td colspan=3>
	  	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#saveJbossModal">수정</button>
	  </td>
	  
  </tr>
</table>

<br>
<h3 class="sub-header">OS Parameters</h3>
<table class="table table-striped">
  <tr>
	<th width="30%">구분</th>
	<th width="40%">입력값</th>
	<th width="30%">설명</th>
  </tr>
  <tr>
	  <td>setup_ulimit</td>
	  <td>${installProperties.setup_ulimit}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>ulimit.0</td>
	  <td>${installProperties['ulimit.0']}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>ulimit.1</td>
	  <td>${installProperties['ulimit.1']}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>setup_kernel_parameters</td>
	  <td>${installProperties.setup_kernel_parameters}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>kernel_parameter.0</td>
	  <td>${installProperties['kernel_parameter.0']}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>kernel_parameter.1</td>
	  <td>${installProperties['kernel_parameter.1']}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>kernel_parameter.2</td>
	  <td>${installProperties['kernel_parameter.2']}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>kernel_parameter.3</td>
	  <td>${installProperties['kernel_parameter.3']}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>kernel_parameter.4</td>
	  <td>${installProperties['kernel_parameter.4']}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>kernel_parameter.5</td>
	  <td>${installProperties['kernel_parameter.5']}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>kernel_parameter.6</td>
	  <td>${installProperties['kernel_parameter.6']}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>kernel_parameter.7</td>
	  <td>${installProperties['kernel_parameter.7']}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>kernel_parameter.8</td>
	  <td>${installProperties['kernel_parameter.8']}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>kernel_parameter.9</td>
	  <td>${installProperties['kernel_parameter.9']}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>tmp_file_path</td>
	  <td>${installProperties.tmp_file_path}</td>
	  <td></td>
  </tr>
  
  <tr>
	  <td colspan=3>
	  	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#saveOSParametersModal">수정</button>
	  </td>
	  
  </tr>
</table>

<br>
<h3 class="sub-header">WEB</h3>
<table class="table table-striped">
  <tr>
	<th width="30%">구분</th>
	<th width="40%">입력값</th>
	<th width="30%">설명</th>
  </tr>
  <tr>
	  <td>install_httpd</td>
	  <td>${installProperties.install_httpd}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>httpd_type</td>
	  <td>${installProperties.httpd_type}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>httpd_file_name</td>
	  <td>${installProperties.httpd_file_name}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>install_httpd_os_package</td>
	  <td>${installProperties.install_httpd_os_package}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>rhel_version</td>
	  <td>${installProperties.rhel_version}</td>
	  <td></td>
  </tr>
  
  <tr>
	  <td colspan=3>
	  	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#saveWebModal">수정</button>
	  </td>
	  
  </tr>
</table>

<br>
<h3 class="sub-header">Connector</h3>
<table class="table table-striped">
  <tr>
	<th width="30%">구분</th>
	<th width="40%">입력값</th>
	<th width="30%">설명</th>
  </tr>
  <tr>
	  <td>httpd_connector_type</td>
	  <td>${installProperties.httpd_connector_type}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>httpd_connector_file_name</td>
	  <td>${installProperties.httpd_connector_file_name}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>install_httpd_connector</td>
	  <td>${installProperties.install_httpd_connector}</td>
	  <td></td>
  </tr>
  
  <tr>
	  <td colspan=3>
	  	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#saveConnectorModal">수정</button>
	  </td>
	  
  </tr>
</table>


<br>
<h3 class="sub-header">ETC</h3>
<table class="table table-striped">
  <tr>
	<th width="30%">구분</th>
	<th width="40%">입력값</th>
	<th width="30%">설명</th>
  </tr>
  <tr>
	  <td>operation_mode</td>
	  <td>${installProperties.operation_mode}</td>
	  <td></td>
  </tr>
  <tr>
	  <td>display_null_value</td>
	  <td>${installProperties.display_null_value}</td>
	  <td></td>
  </tr>
  
  <tr>
	  <td colspan=3>
	  	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#saveEtcModal">수정</button>
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


<!--  JDK Modal -->
<div id="saveJdkModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- dialog body -->
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
        <form name="save_install_properties_jdk_form" method="post" action="${pageContext.request.contextPath}/project/save_install_properties.do">
        	<div class="form-group">
            <label for=jdk_file_name class="control-label">jdk_file_name:</label>
            <input name="jdk_file_name" type="text" class="form-control" id="jdk_file_name" value="">
          </div>
          <div class="form-group">
            <label for=install_jdk class="control-label">install_jdk:</label>
            <input name="install_jdk" type="text" class="form-control" id="install_jdk" value="">
          </div>
          <div class="form-group">
            <label for=use_root_user_for_jdk class="control-label">use_root_user_for_jdk:</label>
            <input name="use_root_user_for_jdk" type="text" class="form-control" id="use_root_user_for_jdk" value="">
          </div>
          
        </form>
      </div>
      <!-- dialog buttons -->
       <div class="modal-footer">
      		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      		<button type="button" class="btn btn-primary" onClick="javascript:save_install_properties_jdk();">수정</button>
      	</div>
    </div>
  </div>
</div>

<script type="text/javascript">
$('#saveJdkModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('JDK정보를 수정합니다.')
	  modal.find('.modal-body #jdk_file_name').val("${installProperties.jdk_file_name}")
	  modal.find('.modal-body #install_jdk').val("${installProperties.install_jdk}")
	  modal.find('.modal-body #use_root_user_for_jdk').val("${installProperties.use_root_user_for_jdk}")
	  
})
</script>


<!--  JBoss Modal -->
<div id="saveJbossModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- dialog body -->
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
        <form name="save_install_properties_jboss_form" method="post" action="${pageContext.request.contextPath}/project/save_install_properties.do">
        	<div class="form-group">
            <label for=install_eap class="control-label">install_eap:</label>
            <input name="install_eap" type="text" class="form-control" id="install_eap" value="">
          </div>
          <div class="form-group">
            <label for=install_eap_os_package class="control-label">install_eap_os_package:</label>
            <input name="install_eap_os_package" type="text" class="form-control" id="install_eap_os_package" value="">
          </div>
          <div class="form-group">
            <label for=jboss_eap_version class="control-label">jboss_eap_version:</label>
            <input name="jboss_eap_version" type="text" class="form-control" id="jboss_eap_version" value="">
          </div>
          <div class="form-group">
            <label for=jboss_engine_file_name class="control-label">jboss_engine_file_name:</label>
            <input name="jboss_engine_file_name" type="text" class="form-control" id="jboss_engine_file_name" value="">
          </div>
          <div class="form-group">
            <label for=install_eap_patch class="control-label">install_eap_patch:</label>
            <input name="install_eap_patch" type="text" class="form-control" id="install_eap_patch" value="">
          </div>
          <div class="form-group">
            <label for=ageout_history class="control-label">ageout_history:</label>
            <input name="ageout_history" type="text" class="form-control" id="ageout_history" value="">
          </div>
          <div class="form-group">
            <label for="jboss_engine_patch_file_name.0" class="control-label">jboss_engine_patch_file_name.0:</label>
            <input name="jboss_engine_patch_file_name.0" type="text" class="form-control" id="jboss_engine_patch_file_name.0" value="">
          </div>
          <div class="form-group">
            <label for="jboss_engine_patch_file_name.1" class="control-label">jboss_engine_patch_file_name.1:</label>
            <input name="jboss_engine_patch_file_name.1" type="text" class="form-control" id="jboss_engine_patch_file_name.1" value="">
          </div>
          <div class="form-group">
            <label for=jboss_eap_native_file_name class="control-label">jboss_eap_native_file_name:</label>
            <input name="jboss_eap_native_file_name" type="text" class="form-control" id="jboss_eap_native_file_name" value="">
          </div>
          <div class="form-group">
            <label for=config_profile class="control-label">config_profile:</label>
            <input name="config_profile" type="text" class="form-control" id="config_profile" value="">
          </div>
          <div class="form-group">
            <label for=module_ext_file_name class="control-label">module_ext_file_name:</label>
            <input name="module_ext_file_name" type="text" class="form-control" id="module_ext_file_name" value="">
          </div>
          <div class="form-group">
            <label for=build_template_only class="control-label">build_template_only:</label>
            <input name="build_template_only" type="text" class="form-control" id="build_template_only" value="">
          </div>
          <div class="form-group">
            <label for=use_native_component class="control-label">use_native_component:</label>
            <input name="use_native_component" type="text" class="form-control" id="use_native_component" value="">
          </div>
          
        </form>
      </div>
      <!-- dialog buttons -->
       <div class="modal-footer">
      		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      		<button type="button" class="btn btn-primary" onClick="javascript:save_install_properties_jboss();">수정</button>
      	</div>
    </div>
  </div>
</div>

<script type="text/javascript">
$('#saveJbossModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('JBoss 정보를 수정합니다.')
	  modal.find('.modal-body #install_eap').val("${installProperties.install_eap}")
	  modal.find('.modal-body #install_eap_os_package').val("${installProperties.install_eap_os_package}")
	  modal.find('.modal-body #jboss_eap_version').val("${installProperties.jboss_eap_version}")
	  modal.find('.modal-body #jboss_engine_file_name').val("${installProperties.jboss_engine_file_name}")
	  modal.find('.modal-body #install_eap_patch').val("${installProperties.install_eap_patch}")
	  modal.find('.modal-body #ageout_history').val("${installProperties.ageout_history}")
	  modal.find('.modal-body #jboss_engine_patch_file_name\\.0').val("${installProperties['jboss_engine_patch_file_name.0']}")
	  modal.find('.modal-body #jboss_engine_patch_file_name\\.1').val("${installProperties['jboss_engine_patch_file_name.1']}")
	  modal.find('.modal-body #jboss_eap_native_file_name').val("${installProperties.jboss_eap_native_file_name}")
	  modal.find('.modal-body #config_profile').val("${installProperties.config_profile}")
	  modal.find('.modal-body #module_ext_file_name').val("${installProperties.module_ext_file_name}")
	  modal.find('.modal-body #build_template_only').val("${installProperties.build_template_only}")
	  modal.find('.modal-body #use_native_component').val("${installProperties.use_native_component}")
	 
})
</script>


<!--  OS Parameters Modal -->
<div id="saveOSParametersModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- dialog body -->
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
        <form name="save_install_properties_os_parameters_form" method="post" action="${pageContext.request.contextPath}/project/save_install_properties.do">
        	<div class="form-group">
            <label for=setup_ulimit class="control-label">setup_ulimit:</label>
            <input name="setup_ulimit" type="text" class="form-control" id="setup_ulimit" value="">
          </div>
          <div class="form-group">
            <label for="ulimit.0" class="control-label">ulimit.0:</label>
            <input name="ulimit.0" type="text" class="form-control" id="ulimit.0" value="">
          </div>
          <div class="form-group">
            <label for="ulimit.1" class="control-label">ulimit.1:</label>
            <input name="ulimit.1" type="text" class="form-control" id="ulimit.1" value="">
          </div>
          <div class="form-group">
            <label for=setup_kernel_parameters class="control-label">setup_kernel_parameters:</label>
            <input name="setup_kernel_parameters" type="text" class="form-control" id="setup_kernel_parameters" value="">
          </div>
          <div class="form-group">
            <label for="kernel_parameter.0" class="control-label">kernel_parameter.0:</label>
            <input name="kernel_parameter.0" type="text" class="form-control" id="kernel_parameter.0" value="">
          </div>
          <div class="form-group">
            <label for="kernel_parameter.1" class="control-label">kernel_parameter.1:</label>
            <input name="kernel_parameter.1" type="text" class="form-control" id="kernel_parameter.1" value="">
          </div>
          <div class="form-group">
            <label for="kernel_parameter.2" class="control-label">kernel_parameter.2:</label>
            <input name="kernel_parameter.2" type="text" class="form-control" id="kernel_parameter.2" value="">
          </div>
          <div class="form-group">
            <label for="kernel_parameter.3" class="control-label">kernel_parameter.3:</label>
            <input name="kernel_parameter.3" type="text" class="form-control" id="kernel_parameter.3" value="">
          </div>
          <div class="form-group">
            <label for="kernel_parameter.4" class="control-label">kernel_parameter.4:</label>
            <input name="kernel_parameter.4" type="text" class="form-control" id="kernel_parameter.4" value="">
          </div>
          <div class="form-group">
            <label for="kernel_parameter.5" class="control-label">kernel_parameter.5:</label>
            <input name="kernel_parameter.5" type="text" class="form-control" id="kernel_parameter.5" value="">
          </div>
          <div class="form-group">
            <label for="kernel_parameter.6" class="control-label">kernel_parameter.6:</label>
            <input name="kernel_parameter.6" type="text" class="form-control" id="kernel_parameter.6" value="">
          </div>
          <div class="form-group">
            <label for="kernel_parameter.7" class="control-label">kernel_parameter.7:</label>
            <input name="kernel_parameter.7" type="text" class="form-control" id="kernel_parameter.7" value="">
          </div>
          <div class="form-group">
            <label for="kernel_parameter.8" class="control-label">kernel_parameter.8:</label>
            <input name="kernel_parameter.8" type="text" class="form-control" id="kernel_parameter.8" value="">
          </div>
          <div class="form-group">
            <label for="kernel_parameter.9" class="control-label">kernel_parameter.9:</label>
            <input name="kernel_parameter.9" type="text" class="form-control" id="kernel_parameter.9" value="">
          </div>
          <div class="form-group">
            <label for=tmp_file_path class="control-label">tmp_file_path:</label>
            <input name="tmp_file_path" type="text" class="form-control" id="tmp_file_path" value="">
          </div>
          
        </form>
      </div>
      <!-- dialog buttons -->
       <div class="modal-footer">
      		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      		<button type="button" class="btn btn-primary" onClick="javascript:save_install_properties_os_parameters();">수정</button>
      	</div>
    </div>
  </div>
</div>

<script type="text/javascript">
$('#saveOSParametersModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('OS Parameters 정보를 수정합니다.')
	  modal.find('.modal-body #setup_ulimit').val("${installProperties.setup_ulimit}")
	  modal.find('.modal-body #ulimit\\.0').val("${installProperties['ulimit.0']}")
	  modal.find('.modal-body #ulimit\\.1').val("${installProperties['ulimit.1']}")
	  modal.find('.modal-body #setup_kernel_parameters').val("${installProperties.setup_kernel_parameters}")
	  modal.find('.modal-body #kernel_parameter\\.0').val("${installProperties['kernel_parameter.0']}")
	  modal.find('.modal-body #kernel_parameter\\.1').val("${installProperties['kernel_parameter.1']}")
	  modal.find('.modal-body #kernel_parameter\\.2').val("${installProperties['kernel_parameter.2']}")
	  modal.find('.modal-body #kernel_parameter\\.3').val("${installProperties['kernel_parameter.3']}")
	  modal.find('.modal-body #kernel_parameter\\.4').val("${installProperties['kernel_parameter.4']}")
	  modal.find('.modal-body #kernel_parameter\\.5').val("${installProperties['kernel_parameter.5']}")
	  modal.find('.modal-body #kernel_parameter\\.6').val("${installProperties['kernel_parameter.6']}")
	  modal.find('.modal-body #kernel_parameter\\.7').val("${installProperties['kernel_parameter.7']}")
	  modal.find('.modal-body #kernel_parameter\\.8').val("${installProperties['kernel_parameter.8']}")
	  modal.find('.modal-body #kernel_parameter\\.9').val("${installProperties['kernel_parameter.9']}")
	  modal.find('.modal-body #tmp_file_path').val("${installProperties.tmp_file_path}")
	 
})
</script>


<!--  Web Modal -->
<div id="saveWebModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- dialog body -->
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
        <form name="save_install_properties_web_form" method="post" action="${pageContext.request.contextPath}/project/save_install_properties.do">
        	<div class="form-group">
            <label for=install_httpd class="control-label">install_httpd:</label>
            <input name="install_httpd" type="text" class="form-control" id="install_httpd" value="">
          </div>
          <div class="form-group">
            <label for="httpd_type" class="control-label">httpd_type:</label>
            <input name="httpd_type" type="text" class="form-control" id="httpd_type" value="">
          </div>
          <div class="form-group">
            <label for="httpd_file_name" class="control-label">httpd_file_name:</label>
            <input name="httpd_file_name" type="text" class="form-control" id="httpd_file_name" value="">
          </div>
          <div class="form-group">
            <label for=install_httpd_os_package class="control-label">install_httpd_os_package:</label>
            <input name="install_httpd_os_package" type="text" class="form-control" id="install_httpd_os_package" value="">
          </div>
          <div class="form-group">
            <label for="rhel_version" class="control-label">rhel_version:</label>
            <input name="rhel_version" type="text" class="form-control" id="rhel_version" value="">
          </div>
          
        </form>
      </div>
      <!-- dialog buttons -->
       <div class="modal-footer">
      		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      		<button type="button" class="btn btn-primary" onClick="javascript:save_install_properties_web();">수정</button>
      	</div>
    </div>
  </div>
</div>

<script type="text/javascript">
$('#saveWebModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var ip = button.data('ip') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Web 정보를 수정합니다.')
	  modal.find('.modal-body #install_httpd').val("${installProperties.install_httpd}")
	  modal.find('.modal-body #httpd_type').val("${installProperties.httpd_type}")
	  modal.find('.modal-body #httpd_file_name').val("${installProperties.httpd_file_name}")
	  modal.find('.modal-body #install_httpd_os_package').val("${installProperties.install_httpd_os_package}")
	  modal.find('.modal-body #rhel_version').val("${installProperties.rhel_version}")
		 
})
</script>


<!--  Web Modal -->
<div id="saveConnectorModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- dialog body -->
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
        <form name="save_install_properties_connector_form" method="post" action="${pageContext.request.contextPath}/project/save_install_properties.do">
        	<div class="form-group">
            <label for=httpd_connector_type class="control-label">httpd_connector_type:</label>
            <input name="httpd_connector_type" type="text" class="form-control" id="httpd_connector_type" value="">
          </div>
          <div class="form-group">
            <label for="httpd_connector_file_name" class="control-label">httpd_connector_file_name:</label>
            <input name="httpd_connector_file_name" type="text" class="form-control" id="httpd_connector_file_name" value="">
          </div>
          <div class="form-group">
            <label for="install_httpd_connector" class="control-label">install_httpd_connector:</label>
            <input name="install_httpd_connector" type="text" class="form-control" id="install_httpd_connector" value="">
          </div>
          
        </form>
      </div>
      <!-- dialog buttons -->
       <div class="modal-footer">
      		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      		<button type="button" class="btn btn-primary" onClick="javascript:save_install_properties_connector();">수정</button>
      	</div>
    </div>
  </div>
</div>

<script type="text/javascript">
$('#saveConnectorModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  //var ip = button.data('ip') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Connector 정보를 수정합니다.')
	  modal.find('.modal-body #httpd_connector_type').val("${installProperties.httpd_connector_type}")
	  modal.find('.modal-body #httpd_connector_file_name').val("${installProperties.httpd_connector_file_name}")
	  modal.find('.modal-body #install_httpd_connector').val("${installProperties.install_httpd_connector}")
	   
})
</script>

<!--  ETC Modal -->
<div id="saveEtcModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- dialog body -->
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="exampleModalLabel"></h4>
        <form name="save_install_properties_etc_form" method="post" action="${pageContext.request.contextPath}/project/save_install_properties.do">
        	<div class="form-group">
            <label for=operation_mode class="control-label">operation_mode:</label>
            <input name="operation_mode" type="text" class="form-control" id="operation_mode" value="">
          </div>
          <div class="form-group">
            <label for="display_null_value" class="control-label">display_null_value:</label>
            <input name="display_null_value" type="text" class="form-control" id="display_null_value" value="">
          </div>
          
        </form>
      </div>
      <!-- dialog buttons -->
       <div class="modal-footer">
      		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      		<button type="button" class="btn btn-primary" onClick="javascript:save_install_properties_etc();">수정</button>
      	</div>
    </div>
  </div>
</div>

<script type="text/javascript">
$('#saveEtcModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  //var ip = button.data('ip') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('Etc 정보를 수정합니다.')
	  modal.find('.modal-body #operation_mode').val("${installProperties.operation_mode}")
	  modal.find('.modal-body #display_null_value').val("${installProperties.display_null_value}")
	   
})
</script>