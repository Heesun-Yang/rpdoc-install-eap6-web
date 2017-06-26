<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" %>

<jsp:include page="/WEB-INF/jsp/inc/header.jsp"></jsp:include>

<jsp:include page="/WEB-INF/jsp/inc/top.jsp"></jsp:include>

<!-- Custom styles for this template -->
<link href="<%=request.getContextPath()%>/resources/dist/css/cover.css" rel="stylesheet">

   <div class="site-wrapper">

      <div class="site-wrapper-inner">
        <div class="cover-container">
          <div class="inner cover">
          
            <h1 class="cover-heading">Create Project</h1>
            
            <p>먼저 프로젝트를 생성한 후 계속 진행할 수 있습니다.</p>
            <p>이전에 생성했던 프로젝트는 우측 상단 Project List에서 찾을 수 있습니다.</p>
            <p>
              <a href="<%=request.getContextPath()%>/project/project_form.do" class="btn btn-lg btn-default">Create Project</a>
            </p>
          </div>

          <div class="mastfoot">
            <div class="inner">
              <p>Copyright 2017 <a href="http://www.rockplace.co.kr">Rockplace Middleware Team</a> all rights reserved.</p>
            </div>
          </div>

        </div>

      </div>

    </div>

<jsp:include page="/WEB-INF/jsp/inc/footer.jsp"></jsp:include>