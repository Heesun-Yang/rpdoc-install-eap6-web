package com.rp.project;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Properties;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ProjectSvc {
	static Logger log = LoggerFactory.getLogger(ProjectSvc.class);
	
	// ProjectSvc 인스턴스 생성 전에도 사용할 수 있도록 static 으로 ProjectSvc 선언
    private static ProjectSvc projectSvc;
    
    // Sample project
    private HashMap<String, Object> ProjectSample;
    private Properties PropertiesSample;
    
    // 프로젝트 목록
    private HashMap<String, Object> ProjectListMap;
    
    public HashMap<String, Object> getProjectListMap() {
		return ProjectListMap;
	}

	public void setProjectListMap(HashMap<String, Object> projectListMap) {
		ProjectListMap = projectListMap;
	}

	// 기본생성자를 private으로 설정하여 외부로부터의 생성방법 차단
    private ProjectSvc() {
    	
    }
    
    // ProjectSvc 생성
    private ProjectSvc(HttpServletRequest request) {
    	// 최초 생성시 프로젝트 리스트 생성
    	this.setProjectListMap(ProjectUtil.getHashMapFromJson(request, "data/projects/project_list.json"));
    	log.info("ProjectListMap is initialized:{}", ProjectListMap);
    	
    	// services.json.sample을 읽어들여 project map 생성
    	ProjectSample = ProjectUtil.getHashMapFromJson(request, "data/services.json.sample");
    	PropertiesSample = ProjectUtil.loadProperties(request, "data/install.properties.sample");
    }
    
    // ProjectSvc 인스턴스 획득
    public static ProjectSvc getInstance(HttpServletRequest request) {
        // ProjectSvc 인스턴스가 null 일경우 새로생성하여 return
        if (projectSvc == null) projectSvc = new ProjectSvc(request);
        return projectSvc;
    }
	
    
	
	public HashMap<String, Object> getProjectSample() {
		return ProjectSample;
	}

	public void setProjectSample(HashMap<String, Object> projectSample) {
		ProjectSample = projectSample;
	}
	
	// Sample Service
	public HashMap<String, Object> getSampleService() {
		ArrayList<Object> services = (ArrayList<Object>)ProjectSample.get("services");
	  	HashMap<String, Object> service = (HashMap<String, Object>)services.get(0);
	  	/*
	  	ArrayList<Object> httpd_hosts = (ArrayList<Object>)service.get("httpd_hosts");
	  	HashMap<String, Object> httpd_host = (HashMap<String, Object>) httpd_hosts.get(0);
	  	*/
		return service;
	}
	
	// Sample Httpd Host
	public HashMap<String, Object> getSampleHttpdHost() {
		HashMap<String, Object> service = this.getSampleService();
	  	
	  	ArrayList<Object> httpd_hosts = (ArrayList<Object>)service.get("httpd_hosts");
	  	HashMap<String, Object> httpd_host = (HashMap<String, Object>) httpd_hosts.get(0);
	  	
		return httpd_host;
	}


	// Sample JBoss Host
	public HashMap<String, Object> getSampleJBossHost() {
		HashMap<String, Object> service = this.getSampleService();
	  	
	  	ArrayList<Object> jboss_hosts = (ArrayList<Object>)service.get("jboss_hosts");
	  	HashMap<String, Object> jboss_host = (HashMap<String, Object>) jboss_hosts.get(0);
	  	
		return jboss_host;
	}


	// Sample JBoss Instance
	public HashMap<String, Object> getSampleJBossInstance() {
		HashMap<String, Object> jboss_host = this.getSampleJBossHost();
		ArrayList<Object> instances = (ArrayList<Object>)jboss_host.get("instances");
		HashMap<String, Object> instance = (HashMap<String, Object>)instances.get(0);
		
		return instance;
	}

	// Project 추가
	public String addProject(HttpServletRequest request, HashMap<String, String> requestMap){
		String methodName = new Object(){}.getClass().getEnclosingMethod().getName();
		log.info("Method: {}", methodName);
		
		// Sample Project의 내용을 복사하여 생성
    	HashMap<String, Object> project = new HashMap<String, Object>();
    	project.putAll(ProjectSample);
    	
    	// Sample Properties의 내용을 복사하여 생성
    	Properties prop = new Properties();
    	ProjectUtil.copyProperties(PropertiesSample, prop);
    	
    	
    	// Project명 중복조회
    	if (ProjectListMap.get(requestMap.get("project_name")) == null){
    		// 프로젝트명 저장
        	project.put("project_name", requestMap.get("project_name"));
        	
        	// UUID 생성
        	String uuid = UUID.randomUUID().toString();
        	
        	// Project List Map에 Project 추가
        	ProjectListMap.put(requestMap.get("project_name"), uuid);
        	
        	// 프로젝트 디렉토리 생성
        	String ProjectHome = request.getServletContext().getRealPath("data/projects");
        	String ProjectDirPath = ProjectHome + File.separator + uuid;
        	ProjectUtil.makeProjectDir(ProjectDirPath);
        	
        	// project별 services.json 파일 생성
        	ProjectUtil.writeHashMapToJson(project, ProjectHome + File.separator + uuid + File.separator + "services.json");
        	
        	// project별 install.properties 파일 생성
        	ProjectUtil.writePropertiesToFile(prop, ProjectHome + File.separator + uuid + File.separator + "install.properties");
        	
        	
        	// ProjectListMap을 project_list.json 파일에 저장
        	ProjectUtil.writeHashMapToJson(ProjectListMap, ProjectHome + File.separator + "project_list.json");
    		
        	// 생성된 sample project를 session 에 저장
        	request.getSession().setAttribute("project", project);
        	
        	return "Success";
    	} else {
    		String errMsg = "Project name is duplicated";
    		log.error("Project name \"{}\" is duplicated", requestMap.get("project_name"));
    		return errMsg;
    	}
    	
    	
	}
	/*
	 project 정보를 json 파일로 부터 로딩
	 세션에 project 정보 업데이트
	*/
	public void getProject(HttpServletRequest request, HashMap<String, String> requestMap){
		String methodName = new Object(){}.getClass().getEnclosingMethod().getName();
		log.info("Method: {}", methodName);
		
    	// Project명 조회
    	if (ProjectListMap.get(requestMap.get("project_name")) != null){
    		
        	// UUID 조회
        	String uuid = ProjectListMap.get(requestMap.get("project_name"))+"";
        	
        	String projectDirectory = "data" + File.separator + "projects" + File.separator + uuid;
        	
        	// Json File Path
        	String JsonFilePath = projectDirectory + File.separator + "services.json";
        	
        	// services.json을 읽어들여 project map 생성
        	HashMap<String, Object> project = ProjectUtil.getHashMapFromJson(request, JsonFilePath);
        	
        	// project를 session 에 저장
        	request.getSession().setAttribute("project", project);
        	
        	// properties File Path
        	String propertiesFilePath = projectDirectory + File.separator +  "install.properties";
        	
        	// install.properties을 읽어들여 Properties 생성
        	Properties properties = ProjectUtil.loadProperties(request, propertiesFilePath);
        	
        	// 생성된 sample project를 session 에 저장
        	request.getSession().setAttribute("properties", properties);
        	
        	
    	} else {
    		
    		log.error("Project {} is invalid in data/projects", requestMap.get("project_name"));
    		
    	}
    	
    	
	}
	/*
	 Project UUID정보 조회 
	*/
	public String getProjectUUID(HttpServletRequest request){
		String methodName = new Object(){}.getClass().getEnclosingMethod().getName();
		log.info("Method: {}", methodName);
		
		// 현재 project 
    	HashMap<String, Object> project = (HashMap<String, Object>)request.getSession().getAttribute("project");
    	
		String projectName = project.get("project_name") + "";
		log.info("projectName: {}", projectName);
		
		// UUID 조회
       String uuid = ProjectListMap.get(projectName) + "";
   	
       return uuid;
   	
	}
	// customer 정보를 HashMap에 저장
	public void saveCustomer(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		HashMap<String, Object> customer = (HashMap<String, Object>)project.get("customer");
		customer.put("name", requestMap.get("name"));
		customer.put("inspection_place", requestMap.get("inspection_place"));
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
    	
	}
	
	// Sales 정보를 HashMap에 저장
	public void saveSales(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		HashMap<String, Object> sales = (HashMap<String, Object>)project.get("sales");
		sales.put("name", requestMap.get("name"));
		sales.put("tel_no", requestMap.get("tel_no"));
		sales.put("email", requestMap.get("email"));
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
    	
	}
	
	// Engineer 정보를 HashMap에 저장
	public void saveEngineer(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		HashMap<String, Object> engineer = (HashMap<String, Object>)project.get("engineer");
		engineer.put("name", requestMap.get("name"));
		engineer.put("tel_no", requestMap.get("tel_no"));
		engineer.put("email", requestMap.get("email"));
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
    	
	}
	
	// Template Host 정보를 HashMap에 저장
	public void saveTemplateHost(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		HashMap<String, Object> template_host = (HashMap<String, Object>)project.get("template_host");
		template_host.put("ip", requestMap.get("ip"));
		template_host.put("os_user_id", requestMap.get("os_user_id"));
		template_host.put("os_user_pw", requestMap.get("os_user_pw"));
		template_host.put("template_path", requestMap.get("template_path"));
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
    	
	}
	// Host Default 정보를 HashMap에 저장
	public void saveHostDefault(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		HashMap<String, Object> host_default_values = (HashMap<String, Object>)project.get("host_default_values");
		host_default_values.put("os_user_id", requestMap.get("os_user_id"));
		host_default_values.put("os_user_pw", requestMap.get("os_user_pw"));
		host_default_values.put("os_root_pw", requestMap.get("os_root_pw"));
		host_default_values.put("java_home", requestMap.get("java_home"));
		host_default_values.put("jboss_home", requestMap.get("jboss_home"));
		host_default_values.put("domain_base", requestMap.get("domain_base"));
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
    	
	}
	
	// Instance Default 정보를 HashMap에 저장
	public void saveInstanceDefault(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		HashMap<String, Object> instance_default_values = (HashMap<String, Object>)project.get("instance_default_values");
		instance_default_values.putAll(requestMap);
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
    	
	}
	
	// ProjectSample 에 있는 첫번째 service를 이용하여 Service 추가
	public void addService(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		//Sample Service 가져오기
		ArrayList<Object> sample_services = (ArrayList<Object>)ProjectSample.get("services");
		HashMap<String, Object> ServiceSample = (HashMap<String, Object>)sample_services.get(0);
		
		//새로운 서비스를 만들어 샘플값을 저장
		HashMap<String, Object> NewService = new HashMap<String, Object>();
		NewService.putAll(ServiceSample);
		
		// 새로운 서비스에 사용자 입력값 저장
		NewService.putAll(requestMap);
		
		// 완성된 새로운 서비스 Map을 프로젝트에 추가 
		ArrayList<Object> services = (ArrayList<Object>)project.get("services");
		services.add(NewService);
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
    	
	}

	// service명과 config_file 정보 수정
	public void saveService(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		//Sample Service 가져오기
		ArrayList<Object> services = (ArrayList<Object>)project.get("services");
		
		
		//  새로운 service 생성하고 copy_src_name 를 복사
		HashMap<String, Object> service = null;
		
		// copy_src_name 과 이름이 같으면 NewService에 복사함.
		for ( Object objService :  services){
			service = (HashMap<String, Object>) objService;
			if (requestMap.get("save_src_name").equals(service.get("name"))){
				service.put("name", requestMap.get("name"));
				service.put("config_file", requestMap.get("config_file"));
				break;
			}
		}
		
		// 파일로 저장
		saveHashMapToJsonFile(project, request);
		
	}
	
	// copy_src_name에 해당하는 service를 복사하여 Service 추가
	public void copyService(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		//Sample Service 가져오기
		ArrayList<Object> services = (ArrayList<Object>)project.get("services");
		
		
		HashMap<String, Object> service = this.getService(project, requestMap.get("copy_src_name"));
		
		//  새로운 service 생성하고 copy_src_name 를 복사
		HashMap<String, Object> NewService = new HashMap<String, Object>();
		
		NewService.putAll(service);
		
		log.info("requestMap:{}", requestMap);
		// 새로운 서비스에 사용자 입력값 저장
		NewService.put("name", requestMap.get("name"));
		
		// 완성된 새로운 서비스 Map을 프로젝트에 추가 
		services.add(NewService);
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
    	
	}
	
	// 선택된 서비스 정보를 리턴
	public HashMap<String, Object> getService(HashMap<String, Object> project, String serviceName){
		//Sample Service 가져오기
		ArrayList<Object> services = (ArrayList<Object>)project.get("services");
		
		
		//  지정된 이름의 서비스 조회
		HashMap<String, Object> service = null;
		
		// name이 같은 service를 리턴.
		for ( Object objService :  services){
			service = (HashMap<String, Object>) objService;
			if (serviceName.equals(service.get("name"))){
				break;
			}
		}
		
		return service;
	}

	// Service 삭제
	public void removeService(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		
		// project에서 Service  삭제
		ArrayList<Object> services = (ArrayList<Object>)project.get("services");
		for ( Object objService :  services){
			HashMap<String, Object> service = (HashMap<String, Object>) objService;
			if (requestMap.get("name").equals(service.get("name"))){
				services.remove(service);
				break;
			}
		}
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
    	
	}
	
	// ProjectSample 에 있는 첫번째 HttpdHost를 이용하여 추가
	public void addHttpdHost(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		//Sample Service 가져오기
		ArrayList<Object> sample_services = (ArrayList<Object>)ProjectSample.get("services");
		HashMap<String, Object> ServiceSample = (HashMap<String, Object>)sample_services.get(0);
		ArrayList<Object> sample_httpd_hosts = (ArrayList<Object>)ServiceSample.get("httpd_hosts");
		HashMap<String, Object> sample_httpd_host = (HashMap<String, Object>)sample_httpd_hosts.get(0);
		
		//새로운 Httpd Host를 만들어 샘플값을 저장
		HashMap<String, Object> NewHttpdHost = new HashMap<String, Object>();
		NewHttpdHost.putAll(sample_httpd_host);
		
		// 새로운 Httpd Host에 사용자 입력값 저장
		NewHttpdHost.putAll(requestMap);
		
		// service_name 이 추가로 들어가므로 삭제
		NewHttpdHost.remove("service_name");
		
		// 완성된 새로운 Httpd Host Map을 프로젝트에 추가 
		HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));
		ArrayList<Object> httpd_hosts = (ArrayList<Object>)service.get("httpd_hosts");
		
		httpd_hosts.add(NewHttpdHost);
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
		
	}

	// Httpd Host IP 및 접속정보 수정
	public void saveHttpdHost(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		
		//  service 가져오기
		HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));
		
		HashMap<String, Object> httpd_host = this.getHttpdHost(service, requestMap.get("org_ip"));
		
		httpd_host.put("ip", requestMap.get("ip"));
		httpd_host.put("os_user_id", requestMap.get("os_user_id"));
		httpd_host.put("os_user_pw", requestMap.get("os_user_pw"));
		httpd_host.put("httpd_home", requestMap.get("httpd_home"));
		
		// 파일로 저장
		saveHashMapToJsonFile(project, request);
		
	}


	// copy_org_ip 에 해당하는 HttpdHost를 복사하여 HttpdHost 추가
	public void copyHttpdHost(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		
		HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));

		//httpd_hosts 가져오기
		ArrayList<Object> httpd_hosts = (ArrayList<Object>)service.get("httpd_hosts");
		
		HashMap<String, Object> HttpdHost = this.getHttpdHost(service, requestMap.get("copy_org_ip"));
		
		//  새로운 HttpdHost 생성하고 copy_org_ip HttpdHost를 복사
		HashMap<String, Object> NewHttpdHost = new HashMap<String, Object>();
		
		NewHttpdHost.putAll(HttpdHost);
		
		log.info("requestMap:{}", requestMap);
		// 새로운 서비스에 사용자 입력값 저장
		NewHttpdHost.put("ip", requestMap.get("ip"));
		
		// 완성된 새로운 서비스 Map을 프로젝트에 추가 
		httpd_hosts.add(NewHttpdHost);
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
    	
	}
	
	// 선택된 Host 정보를 리턴
	public HashMap<String, Object> getHttpdHost(HashMap<String, Object> service, String hostIP){
		
		// IP가 같은 host를 리턴.
		HashMap<String, Object> httpd_host = null;
		ArrayList<Object> httpd_hosts = (ArrayList<Object>)service.get("httpd_hosts");
		
		for ( Object objHttpd_host :  httpd_hosts){
			httpd_host = (HashMap<String, Object>) objHttpd_host;
			if (hostIP.equals(httpd_host.get("ip"))){
				break;
			}
		}
		
		return httpd_host;
	}
	

	// Httpd Host 삭제
	public void removeHttpdHost(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		//  service 가져오기
		HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));
			
		HashMap<String, Object> httpd_host = this.getHttpdHost(service, requestMap.get("ip"));
		
		// project에서 Httpd Host  삭제
		ArrayList<Object> httpd_hosts = (ArrayList<Object>)service.get("httpd_hosts");
		httpd_hosts.remove(httpd_host);
		
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
    	
	}
	
	// Httpd MainConfig 수정
	public void saveHttpdMainConfig(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		
		//  service 가져오기
		HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));
		
		HashMap<String, Object> httpd_host = this.getHttpdHost(service, requestMap.get("ip"));
		
		HashMap<String, Object> config = (HashMap<String, Object>)httpd_host.get("config");
		
		
		config.putAll(requestMap);
		
		// 불필요 필드 삭제
		config.remove("service_name");
		config.remove("ip");
		
		// 파일로 저장
		saveHashMapToJsonFile(project, request);
		
	}

	// Httpd MPM 수정
	public void saveHttpdConfigMpm(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		
		//  service 가져오기
		HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));
		
		HashMap<String, Object> httpd_host = this.getHttpdHost(service, requestMap.get("ip"));
		
		HashMap<String, Object> config = (HashMap<String, Object>)httpd_host.get("config");
		HashMap<String, Object> mpm = (HashMap<String, Object>)config.get("mpm");
		
		
		mpm.putAll(requestMap);
		
		// 불필요 필드 삭제
		mpm.remove("service_name");
		mpm.remove("ip");
		
		// 파일로 저장
		saveHashMapToJsonFile(project, request);
		
	}


	// Httpd Connector 수정
	public void saveHttpdConfigConnector(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		
		//  service 가져오기
		HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));
		
		HashMap<String, Object> httpd_host = this.getHttpdHost(service, requestMap.get("ip"));
		
		HashMap<String, Object> config = (HashMap<String, Object>)httpd_host.get("config");
		HashMap<String, Object> connector = (HashMap<String, Object>)config.get("connector");
		
		String use_connector = (String)connector.get("use_connector");
		
		HashMap<String, Object> connector_values = (HashMap<String, Object>)connector.get(use_connector);
		
		connector_values.putAll(requestMap);
		
		// JkMounts 는 String ArrayList로 들어가야 하므로 다시저장
		ArrayList<String> JkMounts = new ArrayList<String>();
		
		if (requestMap.get("JkMounts") != null && "".equals(requestMap.get("JkMounts"))){
			String[] strJkMounts = requestMap.get("JkMounts").split("(")[1].split("]")[0].split(",");
			for (String e : strJkMounts){
				JkMounts.add(e);
			}
			connector_values.put("JkMounts", JkMounts);
		}
		
		
		// 불필요 필드 삭제
		connector_values.remove("service_name");
		connector_values.remove("ip");
		
		// 파일로 저장
		saveHashMapToJsonFile(project, request);
		
	}

	// Httpd Connector 수정
	public void saveHttpdConfigSsl(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		
		//  service 가져오기
		HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));
		
		HashMap<String, Object> httpd_host = this.getHttpdHost(service, requestMap.get("ip"));
		
		HashMap<String, Object> config = (HashMap<String, Object>)httpd_host.get("config");
		HashMap<String, Object> ssl = (HashMap<String, Object>)config.get("ssl");
		
		ssl.putAll(requestMap);
		
		// 불필요 필드 삭제
		ssl.remove("service_name");
		ssl.remove("ip");
		
		// 파일로 저장
		saveHashMapToJsonFile(project, request);
		
	}

	// ProjectSample 에 있는 첫번째 JBossHost를 이용하여 추가
	public void addJbossHost(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		//Sample Service 가져오기
		ArrayList<Object> sample_services = (ArrayList<Object>)ProjectSample.get("services");
		HashMap<String, Object> ServiceSample = (HashMap<String, Object>)sample_services.get(0);
		ArrayList<Object> sample_jboss_hosts = (ArrayList<Object>)ServiceSample.get("jboss_hosts");
		HashMap<String, Object> sample_jboss_host = (HashMap<String, Object>)sample_jboss_hosts.get(0);
		
		//새로운 Httpd Host를 만들어 샘플값을 저장
		HashMap<String, Object> NewJbossHost = new HashMap<String, Object>();
		NewJbossHost.putAll(sample_jboss_host);
		
		// 새로운 Httpd Host에 사용자 입력값 저장
		NewJbossHost.putAll(requestMap);
		
		// service_name 이 추가로 들어가므로 삭제
		NewJbossHost.remove("service_name");
		
		// 완성된 새로운 Httpd Host Map을 프로젝트에 추가 
		HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));
		ArrayList<Object> jboss_hosts = (ArrayList<Object>)service.get("jboss_hosts");
		
		jboss_hosts.add(NewJbossHost);
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
		
	}

	// Jboss Host IP 및 접속정보 수정
	public void saveJbossHost(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
			
			//  service 가져오기
			HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));
			
			HashMap<String, Object> jboss_host = this.getJbossHost(service, requestMap.get("org_ip"));
			
			jboss_host.put("ip", requestMap.get("ip"));
			jboss_host.put("os_user_id", requestMap.get("os_user_id"));
			jboss_host.put("os_user_pw", requestMap.get("os_user_pw"));
			jboss_host.put("java_home", requestMap.get("java_home"));
			jboss_host.put("jboss_home", requestMap.get("jboss_home"));
			jboss_host.put("domain_base", requestMap.get("domain_base"));
			
			// 파일로 저장
			saveHashMapToJsonFile(project, request);
			
	}

	// 선택된 Host 정보를 리턴
	public HashMap<String, Object> getJbossHost(HashMap<String, Object> service, String hostIP){
		
		// IP가 같은 host를 리턴.
		HashMap<String, Object> jboss_host = null;
		ArrayList<Object> jboss_hosts = (ArrayList<Object>)service.get("jboss_hosts");
		
		for ( Object objJboss_host :  jboss_hosts){
			jboss_host = (HashMap<String, Object>) objJboss_host;
			if (hostIP.equals(jboss_host.get("ip"))){
				break;
			}
		}
		
		return jboss_host;
	}
	
	// copy_org_ip 에 해당하는 JbossHost를 복사하여 추가
	public void copyJbossHost(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		
		HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));

		//jboss_hosts 가져오기
		ArrayList<Object> jboss_hosts = (ArrayList<Object>)service.get("jboss_hosts");
		
		HashMap<String, Object> JbossHost = this.getJbossHost(service, requestMap.get("copy_org_ip"));
		
		//  새로운 HttpdHost 생성하고 copy_org_ip HttpdHost를 복사
		HashMap<String, Object> NewJbossHost = new HashMap<String, Object>();
		
		NewJbossHost.putAll(JbossHost);
		
		log.info("requestMap:{}", requestMap);
		// 새로운 서비스에 사용자 입력값 저장
		NewJbossHost.put("ip", requestMap.get("ip"));
		
		// 완성된 새로운 서비스 Map을 프로젝트에 추가 
		jboss_hosts.add(NewJbossHost);
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
    	
	}

	// Jboss Host 삭제
	public void removeJbossHost(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		//  service 가져오기
		HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));
			
		HashMap<String, Object> jboss_host = this.getJbossHost(service, requestMap.get("ip"));
		
		// project에서 Jboss Host  삭제
		ArrayList<Object> jboss_hosts = (ArrayList<Object>)service.get("jboss_hosts");
		jboss_hosts.remove(jboss_host);
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
    	
	}

	// 선택된 Instance 정보를 리턴
	public HashMap<String, Object> getJbossInstance(HashMap<String, Object> service, String hostIP, String instanceName){
		
		// IP가 같은 host를 리턴.
		HashMap<String, Object> jboss_host = null;
		HashMap<String, Object> instance = null;
		
		jboss_host = this.getJbossHost(service, hostIP);
		
		ArrayList<Object> instances = (ArrayList<Object>)jboss_host.get("instances");
		
		for ( Object objInstance :  instances){
			instance = (HashMap<String, Object>) objInstance;
			if (instanceName.equals(instance.get("instance_name"))){
				break;
			}
		}
		
		return instance;
	}
	
	// ProjectSample 에 있는 첫번째 JBossHost Instance를 이용하여 추가
	public void addJbossInstance(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		//Sample Service 가져오기
		ArrayList<Object> sample_services = (ArrayList<Object>)ProjectSample.get("services");
		HashMap<String, Object> ServiceSample = (HashMap<String, Object>)sample_services.get(0);
		
		// Sample Host
		ArrayList<Object> sample_jboss_hosts = (ArrayList<Object>)ServiceSample.get("jboss_hosts");
		HashMap<String, Object> sample_jboss_host = (HashMap<String, Object>)sample_jboss_hosts.get(0);

		// Sample Instance
		ArrayList<Object> sample_instances = (ArrayList<Object>)sample_jboss_host.get("instances");
		HashMap<String, Object> sample_instance = (HashMap<String, Object>)sample_instances.get(0);
		
		//새로운 Instance를 만들어 샘플값을 저장
		HashMap<String, Object> NewInstance = new HashMap<String, Object>();
		NewInstance.putAll(sample_instance);
		
		// 새로운Instance에 사용자 입력값 저장
		NewInstance.putAll(requestMap);
		
		// ip, service_name 이 추가로 들어가므로 삭제
		NewInstance.remove("service_name");
		NewInstance.remove("ip");
		
		// 완성된 새로운 Instance Map을 프로젝트에 추가 
		HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));
		
		HashMap<String, Object> jboss_host = this.getJbossHost(service, requestMap.get("ip"));
		
		ArrayList<Object> instances = (ArrayList<Object>)jboss_host.get("instances");
		
		instances.add(NewInstance);
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
		
	}


	// Jboss instance 정보 수정
	public void saveJbossInstance(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
			
			//  service 가져오기
			HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));
			
			HashMap<String, Object> instance = this.getJbossInstance(service, requestMap.get("ip"), requestMap.get("instance_name"));
			
			instance.putAll(requestMap);
			
			// ip, service_name 제거
			instance.remove("ip");
			instance.remove("service_name");
			
			
			// 파일로 저장
			saveHashMapToJsonFile(project, request);
			
	}
	

	// 선택된 인스턴스를 이용하여 새로운 인스턴스 추가
	public void copyJbossInstance(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		
		HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));

		
		HashMap<String, Object> JbossHost = this.getJbossHost(service, requestMap.get("ip"));
		
		//instances 가져오기
		ArrayList<Object> instances = (ArrayList<Object>)JbossHost.get("instances");
		
		HashMap<String, Object> instance = this.getJbossInstance(service, requestMap.get("ip"), requestMap.get("copy_org_instance_name"));
		
				
		//  새로운 Instance 생성하고 copy_org_instance_name Instance를 복사
		HashMap<String, Object> NewInstance = new HashMap<String, Object>();
		
		NewInstance.putAll(instance);
		
		log.info("requestMap:{}", requestMap);
		// 새로운 Instance에 사용자 입력값 저장
		NewInstance.put("instance_name", requestMap.get("instance_name"));
		NewInstance.put("port_offset", requestMap.get("port_offset"));
		
		// 완성된 새로운 Instance Map을 프로젝트에 추가 
		instances.add(NewInstance);
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
    	
	}


	// Jboss Instance 삭제
	public void removeJbossInstance(HashMap<String, Object> project, HttpServletRequest request, HashMap<String, String> requestMap){
		//  service 가져오기
		HashMap<String, Object> service = this.getService(project, requestMap.get("service_name"));
			
		HashMap<String, Object> jboss_host = this.getJbossHost(service, requestMap.get("ip"));
		HashMap<String, Object> instance = this.getJbossInstance(service, requestMap.get("ip"), requestMap.get("instance_name"));
		
		// project에서 Jboss Instance  삭제
		ArrayList<Object> instances = (ArrayList<Object>)jboss_host.get("instances");
		instances.remove(instance);
		
		// 파일로 저장
		this.saveHashMapToJsonFile(project, request);
    	
	}

	
	// HashMap을 Json파일로 저장
	public void saveHashMapToJsonFile(HashMap<String, Object> project, HttpServletRequest request){
		// UUID 조회
    	String uuid = ProjectListMap.get(project.get("project_name"))+"";
    	
    	// services.json 파일에 저장
		String ProjectHome = request.getServletContext().getRealPath("data/projects");
    	String ProjectDirPath = ProjectHome + File.separator + uuid;
		ProjectUtil.writeHashMapToJson(project, ProjectDirPath + File.separator + "services.json");
	}
	
	
}
