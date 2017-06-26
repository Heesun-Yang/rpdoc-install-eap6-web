package com.rp.project;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class ProjectController {
	static Logger log = LoggerFactory.getLogger(ProjectController.class);
	
	//호출 URI 정의 - 프로젝트 생성 폼
    @RequestMapping(value = "/project/project_form.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String addProjectForm(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> map) {
    	 
    	//model.addAttribute("operation_mode", map.get("operation_mode") );
    	
    	return "project/project_form";
    }
    
    //호출 URI 정의 - 프로젝트 추가
    @RequestMapping(value = "/project/add_project.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String addProject(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	log.info("requestMap:{}", requestMap);
    	
    	// ProjectSvc 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	
    	String msg = projectSvc.addProject(request, requestMap);
    	model.addAttribute("msg", msg);
    	
    	return "project/customer_view";
    }
    //호출 URI 정의 - 프로젝트 정보로딩
    @RequestMapping(value = "/project/get_project.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String getProject(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	String methodName = new Object(){}.getClass().getEnclosingMethod().getName();
		log.info("Method: {}", methodName);
		
    	log.info("get_project requestMap:{}", requestMap);
    	
    	// ProjectSvc 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	
    	// project map을 로딩하여 세션에 저장
    	projectSvc.getProject(request, requestMap);
    	
    	
    	return "project/customer_view";
    }
    //호출 URI 정의 - 프로젝트 list
    @RequestMapping(value = "/project/get_project_list.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String getProjectList(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	String methodName = new Object(){}.getClass().getEnclosingMethod().getName();
		log.info("Method: {}", methodName);
		
    	log.info("requestMap:{}", requestMap);
    	
    	// ProjectSvc 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	model.addAttribute("list", projectSvc.getProjectListMap() );
    	
    	return "project/project_list";
    }

}
