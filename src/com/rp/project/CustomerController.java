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
public class CustomerController {
	static Logger log = LoggerFactory.getLogger(CustomerController.class);
	
	 //호출 URI 정의 -  Customer 조회
    @RequestMapping(value = "/project/get_customer.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String getCustomer(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	
    	return "project/customer_view";
    }
    
    //호출 URI 정의 -  Customer 편집
    @RequestMapping(value = "/project/edit_customer.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String editCustomer(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	
    	return "project/customer_form";
    }
    
    //호출 URI 정의 -  Customer 저장
    @RequestMapping(value = "/project/save_customer.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String saveCustomer(Locale locale,
                                   Model model,
                                   @RequestParam HashMap<String, String> requestMap,
                                   HttpServletRequest request
                                   ) {
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
    	// 처리 인스턴스 획득
    	ProjectSvc projectSvc = ProjectSvc.getInstance(request);
    	projectSvc.saveCustomer(project, request, requestMap);
    	
    	log.info("project:{}", project);
    	
    	return "project/customer_view";
    }
    
}
