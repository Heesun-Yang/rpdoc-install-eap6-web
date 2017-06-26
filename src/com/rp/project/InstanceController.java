package com.rp.project;

import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class InstanceController {

	//호출 URI 정의 -  JBoss Instance 추가
    @RequestMapping(value = "/project/add_jboss_instance.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String addJbossInstance(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	// 현재 project 
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.addJbossInstance(project, request, requestMap);
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }
    
    //호출 URI 정의 -  JBoss Instance 저장
    @RequestMapping(value = "/project/save_jboss_instance.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String saveJbossInstance(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	// 현재 project 
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.saveJbossInstance(project, request, requestMap);
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }

    //호출 URI 정의 -  JBoss Instance 복사
    @RequestMapping(value = "/project/copy_jboss_instance.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String copyJbossInstance(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	// 현재 project 
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.copyJbossInstance(project, request, requestMap);
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }
    

    //호출 URI 정의 -  JBoss Instance 삭제
    @RequestMapping(value = "/project/remove_jboss_instance.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String removeJbossInstance(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	// 현재 project 
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.removeJbossInstance(project, request, requestMap);
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }
    
}
