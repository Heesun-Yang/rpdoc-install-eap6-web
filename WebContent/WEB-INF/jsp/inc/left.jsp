<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

		  <div class="col-sm-3 col-md-2 sidebar">
		  	<ul class="nav nav-sidebar">
            <li><a href="#"><b>Project : ${project.project_name}</b></a></li>
          </ul>
          
          <ul class="nav nav-sidebar">
            <li <c:if test="${param.left_menu=='customer'}">class="active"</c:if>>
            	<a href="${pageContext.request.contextPath}/project/get_customer.do?left_menu=customer">Customer</a>
            </li>
            <li <c:if test="${param.left_menu=='sales'}">class="active"</c:if>>
            	<a href="${pageContext.request.contextPath}/project/get_sales.do?left_menu=sales">Sales</a>
            </li>
            <li <c:if test="${param.left_menu=='engineer'}">class="active"</c:if>>
            	<a href="${pageContext.request.contextPath}/project/get_engineer.do?left_menu=engineer">Engineer</a>
            </li>
          </ul>
          <ul class="nav nav-sidebar">
            	<li <c:if test="${param.left_menu=='template_host'}">class="active"</c:if>>
            		<a href="${pageContext.request.contextPath}/project/get_template_host.do?left_menu=template_host">Template Host</a>
            	</li>
            	<li <c:if test="${param.left_menu=='host_default'}">class="active"</c:if>>
            		<a href="${pageContext.request.contextPath}/project/get_host_default.do?left_menu=host_default">Host Default</a>
            	</li>
            	<li <c:if test="${param.left_menu=='instance_default'}">class="active"</c:if>>
            		<a href="${pageContext.request.contextPath}/project/get_instance_default.do?left_menu=instance_default">Instance Default</a>
            	</li>
           	<li <c:if test="${param.left_menu=='service'}">class="active"</c:if>>
            		<a href="${pageContext.request.contextPath}/project/get_service_list.do?left_menu=service">Service</a>
            	</li>
           	
          </ul>
          <ul class="nav nav-sidebar">
            <li <c:if test="${param.left_menu=='install_properties'}">class="active"</c:if>>
            	<a href="${pageContext.request.contextPath}/project/get_install_properties.do">Install Properties</a>
            </li>
          </ul>
         </div>