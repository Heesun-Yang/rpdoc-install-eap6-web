package com.rp.project;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.nio.charset.Charset;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Properties;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class ProjectUtil {
	static Logger log = LoggerFactory.getLogger(ProjectSvc.class);
	
	// data/services.json.sample 파일을 읽어서 HashMap으로 Return한다.
	public static HashMap<String, Object> getHashMapFromJson(HttpServletRequest request, String jsonFilePath){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
    	
		
    	// JsonFile 파일을 읽어 HashMap으로 저장
    	String  realJsonFilePath = request.getServletContext().getRealPath(jsonFilePath);
    	// JDK6
    	
    	log.info("jsonFilePath:{}", realJsonFilePath);
		
		File file = new File(realJsonFilePath);
		byte[] JsonData; 
		
		// services.json 파일을 읽어 services_map에 저장한다.
		try {
			JsonData = FileUtils.readFileToByteArray(file);
			
			// Jackson ObjectMapper
			ObjectMapper mapper = new ObjectMapper();
			
			// services.json 파일의 내용을 HashMap 으로 변환한다.
			map = mapper.readValue(JsonData, HashMap.class) ;
			
			
			log.info("map:{}", map);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return map;
	}
	
	// HashMap을 Json 파일로 저장
	public static void writeHashMapToJson(HashMap<String, Object> map, String jsonFilePath){
		// Jackson ObjectMapper
		ObjectMapper mapper = new ObjectMapper();
		
		log.debug("plist_map:{}", map);
		log.info("jsonFilePath:{}", jsonFilePath);
		
		try {
			FileUtils.writeStringToFile(new File(jsonFilePath), mapper.writerWithDefaultPrettyPrinter().writeValueAsString(map));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// Properties을 파일로 저장
	public static void writePropertiesToFile(Properties prop, String propertiesFilePath){
		// Jackson ObjectMapper
		//ObjectMapper mapper = new ObjectMapper();
		File f = new File(propertiesFilePath);
		OutputStream out = null;
		
		log.info("prop:{}", prop);
		log.info("propertiesFilePath:{}", propertiesFilePath);
		
		try {
			out = new FileOutputStream( f );
			prop.store(out, "Installation Properties");
			
			//FileUtils.writeStringToFile(new File(propertiesFilePath), mapper.writeValueAsString(prop));
		} catch (IOException io) {
			io.printStackTrace();
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}
	}
	
	// Properties 설정값 로딩 (작업중)
	public static Properties loadProperties(HttpServletRequest request, String propertiesFilePath) {
		Properties prop = new Properties() {
		    @Override
		    public synchronized Enumeration<Object> keys() {
		        return Collections.enumeration(new TreeSet<Object>(super.keySet()));
		    }
		};
		
		InputStream input = null;
		
		try {
			String  realPropertiesFilePath = request.getServletContext().getRealPath(propertiesFilePath);
			//String config_file_path = System.getProperty("user.dir") + File.separator + "data" + File.separator + "install.properties.sample";

			input = new FileInputStream(realPropertiesFilePath);

			// load a properties file- 한글 처리를 위해 InputStreamReader를 사용한다.
			//prop.load(input);
			prop.load(new InputStreamReader(input, Charset.forName("UTF-8")));
			
			// get the property value and print it out
			log.info("Load Properties");
			log.debug("Properties:{}", prop);
			
			
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return prop;
	}
	
	
	// Directory 생성
	public static void makeProjectDir(String ProjectName){
		File dir = new File(ProjectName);
		try {
			FileUtils.forceMkdir(dir);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// Properties 복사
	public static void copyProperties(Properties src_prop, Properties dest_prop)
	  {
	      for (Enumeration propertyNames = src_prop.propertyNames(); propertyNames.hasMoreElements(); )
	      {
	          Object key = propertyNames.nextElement();
	          dest_prop.put(key, src_prop.get(key));
	      }
	  }
}
