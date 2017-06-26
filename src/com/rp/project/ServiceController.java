package com.rp.project;

import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.rp.project.dto.Customer;


@Controller
public class ServiceController {
	static Logger log = LoggerFactory.getLogger(ServiceController.class);
	
	//호출 URI 정의 -  service 추가
    @RequestMapping(value = "/project/add_service.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String addService(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	// 현재 project 
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.addService(project, request, requestMap);
    	
    	return "project/service_list";
    }
    //호출 URI 정의 -  service copy 추가
    @RequestMapping(value = "/project/copy_service.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String copyService(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	// 현재 project 
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.copyService(project, request, requestMap);
    	
    	return "project/service_list";
    }
    
	//호출 URI 정의 -  service list 조회
    @RequestMapping(value = "/project/get_service_list.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String getServiceList(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	
    	return "project/service_list";
    }
    
	 //호출 URI 정의 -  service 조회
    @RequestMapping(value = "/project/get_service.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String getService(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	// 현재 project 
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }
    
    
    //호출 URI 정의 -  service 저장
    @RequestMapping(value = "/project/save_service.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String saveService(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.saveService(project, request, requestMap);
    	
    	log.info("project:{}", project);
    	
    	return "project/service_list";
    }
    //호출 URI 정의 -  service 삭제
    @RequestMapping(value = "/project/remove_service.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String removeService(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	// 현재 project 
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.removeService(project, request, requestMap);
    	
    	return "project/service_list";
    }
    
}
