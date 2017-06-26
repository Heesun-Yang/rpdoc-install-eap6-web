package com.rp.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.rp.project.ProjectController;

@WebFilter(urlPatterns = { "/*" })
public class SessionFilter implements Filter{
	static Logger log = LoggerFactory.getLogger(ProjectController.class);
	
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {    
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		HttpSession session = request.getSession(false);
		String loginURI = request.getContextPath() + "/index.jsp";
		
		//추가 허용 URI
		HashMap<String,Boolean> AllowUriMap = new HashMap<String,Boolean>();
		AllowUriMap.put(request.getContextPath() + "/project/project_form.do", true);
		AllowUriMap.put(request.getContextPath() + "/project/get_project_list.do", true);
		AllowUriMap.put(request.getContextPath() + "/project/get_project.do", true);
		AllowUriMap.put(request.getContextPath() + "/project/add_project.do", true);
		
		// project를 선택한 경우 true
		boolean projectSelected = session != null && session.getAttribute("project") != null;
		// login url과 같은경우 true
		boolean loginRequest = request.getRequestURI().equals(loginURI);
		// resources 디렉토리 아래를 호출한 경우 true
		boolean resourceRequest = request.getRequestURI().startsWith(request.getContextPath() + "/resources");
		
		/*if (session != null){
			log.info("Filter session:{}",session.getAttribute("project")+"");
		} else {
			log.info("session is null");
		}
		
    */
		if (projectSelected || loginRequest || resourceRequest || checkAllowUri(AllowUriMap, request)) {
			//계속 진행
			chain.doFilter(request, response);
		} else {
			response.sendRedirect(loginURI);
	    }
    }
	
	// HashMap에 Allowed URI 가 있으면 true
	private boolean checkAllowUri(HashMap<String,Boolean> AllowUriMap, HttpServletRequest request){
		if (AllowUriMap.get(request.getRequestURI()) == null){
			return false;
		} 
		return true;
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
