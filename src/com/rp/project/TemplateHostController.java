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
public class TemplateHostController {
	static Logger log = LoggerFactory.getLogger(TemplateHostController.class);
	
	 //호출 URI 정의 -  template_host 조회
    @RequestMapping(value = "/project/get_template_host.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String getTemplateHost(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	
    	return "project/template_host_view";
    }
    
    //호출 URI 정의 -  template_host 편집
    @RequestMapping(value = "/project/edit_template_host.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String editTemplateHost(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	
    	return "project/template_host_form";
    }
    
    //호출 URI 정의 -  template_host 저장
    @RequestMapping(value = "/project/save_template_host.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String saveTemplateHost(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.saveTemplateHost(project, request, requestMap);
    	
    	log.info("project:{}", project);
    	
    	return "project/template_host_view";
    }
    
}
