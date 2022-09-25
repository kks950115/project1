package com.korea.gfair.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2
// 네이버 캡차 API 1- 키발급
public class ApiCaptchaNkey {

	public static final String CLIENT_ID = "ZUnxfY75ooCiIvdXXZqx"; 	//애플리케이션 클라이언트 아이디
	public static final String CLIENT_SECRET = "pUwuaVG7n5"; 		//애플리케이션 클라이언트 시크릿
   
	//다른곳에서 쓸 수 있도록 static으로 선언. 
	public static final String captchaNkey(){

        String code = "0"; // 키 발급시 0,  캡차 이미지 비교시 1로 세팅
        String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code;

        //요청헤더를 담을 Map 객체 생성
        Map<String, String> requestHeaders = new HashMap<>();
        //Key 이름은 변경하면 안 됨! 
        requestHeaders.put("X-Naver-Client-Id", ApiCaptchaNkey.CLIENT_ID);			//클라이언트 아이디
        requestHeaders.put("X-Naver-Client-Secret", ApiCaptchaNkey.CLIENT_SECRET);	//클라이언트 시크릿
        
        //응답 받은 결과 저장
        String responseBody = ApiCaptchaNkey.get(apiURL, requestHeaders);	//apiURL로 요청 헤더 전송
        
        //응답 결과 출력
        log.info("\t+ responseBody : "+responseBody);
        
        //JSON 객체를 java 객체로 변경 
        Gson gson = new Gson();
        Captcha cap = gson.<Captcha>fromJson(responseBody, Captcha.class);
        
        log.info("cap : {}", cap);
        log.info("cap.getKey : {}", cap.getKey());
        
        return cap.getKey();	//요청키 Return 
    }//main

    
    //요청 보낼 api URL 주소와 요청 헤더를 담은 MAP 객체를 매개변수로 받는 get 메서드
    private static String get(String apiUrl, Map<String, String> requestHeaders){
       
    	//HttpURLConnection 객체 생성 
    	HttpURLConnection con = ApiCaptchaNkey.connect(apiUrl);
       
		try {
				con.setRequestMethod("GET");
				
				for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
						con.setRequestProperty(header.getKey(), header.getValue());
					}//for
	
				int responseCode = con.getResponseCode(); 		//응답 코드 
				
				if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출. 상태코드 200일때 
						
						//스트림 객체를 매개변수로 readBody 메서드 호출
						return ApiCaptchaNkey.readBody(con.getInputStream());
					} else {									 // 에러 발생
						//readBody 메서드에 null 전달
						return ApiCaptchaNkey.readBody(con.getErrorStream());
					}//if-else
			
			} catch (IOException e) {
				throw new RuntimeException("API 요청과 응답 실패", e);
			} finally {
				con.disconnect();
			}//try-catch-finally
		
    }//get

    private static HttpURLConnection connect(String apiUrl){
        try {
            
        		//api 요청 URL로 URL객체 생성
        		URL url = new URL(apiUrl);
        	
            	return (HttpURLConnection)url.openConnection();	//Connection open
            
        	} catch (MalformedURLException e) {
        		throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        	} catch (IOException e) {
        		throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        	}//try-catch
        
    }//connect

    private static String readBody(InputStream body){
        
    	try {
    		//매개 변수로 받은 InputStream 객체를 사용하여 객체 생성
        	InputStreamReader streamReader = new InputStreamReader(body);
            
            //보조 스트림 장착
            BufferedReader lineReader = new BufferedReader(streamReader);
            
            try (lineReader;) {
            		//String builder 객체 생성 응답 바디에 메시지를 담기 위한 용도로. 
    	        	StringBuilder responseBody = new StringBuilder();
    	            
    	            String line;
    	            
    	            //line 변수에 매개변수로 받은 body를 읽어서 저장.  
    	            //line 변수가 null 이 아닐 동안 반복
    	            while ((line = lineReader.readLine()) != null) {
    	            		responseBody.append(line);	//responseBody에 line 추가. 
    	            	}//while
    	
    	            return responseBody.toString();	//toString 메서드를 사용하여 String 변수로 리턴
                
    	        }//try-with-resources 
    		
    	}catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
        }//try-with-resources
    
    }//readBody
    
    
}//end class
