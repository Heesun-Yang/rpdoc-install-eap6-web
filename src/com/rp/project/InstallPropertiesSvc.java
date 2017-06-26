package com.rp.project;

import java.io.File;
import java.util.HashMap;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class InstallPropertiesSvc {
	static Logger log = LoggerFactory.getLogger(ProjectSvc.class);
	
	private static InstallPropertiesSvc installPropertiesSvc;
	
	// 기본생성자를 private으로 설정하여 외부로부터의 생성방법 차단
    private InstallPropertiesSvc() {
    	
    }
    
    // ProjectSvc 인스턴스 획득
    public static InstallPropertiesSvc getInstance(HttpServletRequest request) {
        // ProjectSvc 인스턴스가 null 일경우 새로생성하여 return
        if (installPropertiesSvc == null) installPropertiesSvc = new InstallPropertiesSvc();
        return installPropertiesSvc;
    }
    
    // get Properties
    public Properties getInstallProperties(HttpServletRequest request, HashMap<String, String> requestMap){
    	Properties properties = (Properties)request.getSession().getAttribute("properties");
    	return properties;
    }
    
    // customer 정보를 HashMap에 저장
 	public void saveInstallProperties(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
 		Properties properties = (Properties)request.getSession().getAttribute("properties");
 		
 		for(String key : requestMap.keySet()) {
 			log.info("key:" + key);
 			properties.setProperty(key, requestMap.get(key));
 		}
 		
 		// 파일로 저장
 		this.savePropertiesToFile(request);
     	
 	}
 	

	// Properties을 파일로 저장
	public void savePropertiesToFile(HttpServletRequest request){
		
		HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
		Properties properties = (Properties)request.getSession().getAttribute("properties");
		
		// UUID 조회
		ProjectSvc projectSvc = ProjectSvc.getInstance(request);
		String uuid = projectSvc.getProjectListMap().get(project.get("project_name"))+"";
		
    	// properties 를 install.properties 파일에 저장
		String ProjectHome = request.getServletContext().getRealPath("data/projects");
    	ProjectUtil.writePropertiesToFile(properties, ProjectHome + File.separator + uuid + File.separator + "install.properties");
    	
	}
	
    
    
    
}
