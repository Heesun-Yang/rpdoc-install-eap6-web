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

@Controller
public class HostController {
	static Logger log = LoggerFactory.getLogger(ServiceController.class);
	
	//호출 URI 정의 -  HTTPD Host 추가
    @RequestMapping(value = "/project/add_httpd_host.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String addHttpdHost(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	// 현재 project 
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.addHttpdHost(project, request, requestMap);
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }
    //호출 URI 정의 -  HTTPD Host 복사
    @RequestMapping(value = "/project/copy_httpd_host.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String copyHttpdHost(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	// 현재 project 
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.copyHttpdHost(project, request, requestMap);
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }
	
	//호출 URI 정의 -  HttpdHost 저장
    @RequestMapping(value = "/project/save_httpd_host.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String saveHttpdHost(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.saveHttpdHost(project, request, requestMap);
    	
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }
    

	//호출 URI 정의 -  Httpd main_config 저장
    @RequestMapping(value = "/project/save_httpd_main_config.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String saveHttpdMainConfig(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.saveHttpdMainConfig(project, request, requestMap);
    	
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }
    

	//호출 URI 정의 -  Httpd MPM 저장
    @RequestMapping(value = "/project/save_httpd_config_mpm.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String saveHttpdConfigMpm(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.saveHttpdConfigMpm(project, request, requestMap);
    	
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }
    

	//호출 URI 정의 -  Httpd Connector 저장
    @RequestMapping(value = "/project/save_httpd_config_connector.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String saveHttpdConfigConnector(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.saveHttpdConfigConnector(project, request, requestMap);
    	
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }

	//호출 URI 정의 -  Httpd SSL 저장
    @RequestMapping(value = "/project/save_httpd_config_ssl.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String saveHttpdConfigSsl(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.saveHttpdConfigSsl(project, request, requestMap);
    	
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }
    
  	//호출 URI 정의 -  HttpdHost 삭제
    @RequestMapping(value = "/project/remove_httpd_host.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String removeHttpdHost(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.removeHttpdHost(project, request, requestMap);
    	
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }
    
    //호출 URI 정의 -  JbossHost 저장
    @RequestMapping(value = "/project/save_jboss_host.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String saveJbossHost(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.saveJbossHost(project, request, requestMap);
    	
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }
    
    

	//호출 URI 정의 -  HTTPD Host 추가
    @RequestMapping(value = "/project/add_jboss_host.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String addJbossHost(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	// 현재 project 
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.addJbossHost(project, request, requestMap);
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }
    
  //호출 URI 정의 -  Jboss Host 복사
    @RequestMapping(value = "/project/copy_jboss_host.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String copyJbossHost(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	// 현재 project 
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.copyJbossHost(project, request, requestMap);
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }

  	//호출 URI 정의 -  Jboss Host 삭제
    @RequestMapping(value = "/project/remove_jboss_host.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String removeJbossHost(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.removeJbossHost(project, request, requestMap);
    	
    	
    	HashMap<String, Object> service = projectSvc.getService(project, requestMap.get("service_name"));
    	model.addAttribute("service", service);
    	
    	return "project/service_view";
    }
    
}
