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
public class InstallPropertiesController {
	static Logger log = LoggerFactory.getLogger(InstanceDefaultController.class);
	
	//호출 URI 정의 -  install properties 조회
    @RequestMapping(value = "/project/get_install_properties.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String getInstallProperties(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	InstallPropertiesSvc installPropertiesSvc = InstallPropertiesSvc.getInstance(request);
    	
    	model.addAttribute("installProperties", installPropertiesSvc.getInstallProperties(request, requestMap));
    	
    	return "project/install_properties_view";
    }
    
    //호출 URI 정의 -   install properties 저장
    @RequestMapping(value = "/project/save_install_properties.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String saveInstallProperties(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	InstallPropertiesSvc installPropertiesSvc = InstallPropertiesSvc.getInstance(request);
    	
    	// 저장
    	installPropertiesSvc.saveInstallProperties(project, request, requestMap);
    	
    	// 조회
    	model.addAttribute("installProperties", installPropertiesSvc.getInstallProperties(request, requestMap));
    	
    	log.info("project:{}", project);
    	
    	return "redirect:/project/get_install_properties.do";
    }
}
