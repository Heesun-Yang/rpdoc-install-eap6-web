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
public class InstanceDefaultController {
	static Logger log = LoggerFactory.getLogger(InstanceDefaultController.class);
	
	 //호출 URI 정의 -  instance_default 조회
    @RequestMapping(value = "/project/get_instance_default.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String getInstanceDefault(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	
    	return "project/instance_default_view";
    }
    
    //호출 URI 정의 -  instance_default 편집
    @RequestMapping(value = "/project/edit_instance_default.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String editInstanceDefault(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	
    	return "project/instance_default_form";
    }
    
    //호출 URI 정의 -  instance_default 저장
    @RequestMapping(value = "/project/save_instance_default.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String saveInstanceDefault(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.saveInstanceDefault(project, request, requestMap);
    	
    	log.info("project:{}", project);
    	
    	return "project/instance_default_view";
    }
    
}
