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

// 네이버 캡차 API 3.- 키발급, 키 비교
public class ApiCaptchaNkeyResult {
						// 캡차 키 발급시 받은 키값, 사용자가 입력한 캡차 이미지 코드값
    public static String getResult(String key, String value) {
      
        String code = "1"; // 키 발급시 0,  캡차 이미지 비교시 1로 세팅
        //ApiUrl에 키값과 코드값 쿼리스트링으로 저장. 
        String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code + "&key=" + key + "&value=" + value;

        //요청헤더 
        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", ApiCaptchaNkey.CLIENT_ID);
        requestHeaders.put("X-Naver-Client-Secret", ApiCaptchaNkey.CLIENT_SECRET);
        
        //응답 문서 저장. 
        String responseBody = ApiCaptchaNkeyResult.get(apiURL, requestHeaders);

//        log.info(responseBody);
//        Gson gson = new Gson();
//        Captcha cap = gson.<Captcha>fromJson(responseBody, Captcha.class);
//        
        return responseBody;
    }//
    
    public static String getResult(String key, String value, String jinsung) {

        String code = "1"; // 키 발급시 0,  캡차 이미지 비교시 1로 세팅
        //ApiUrl에 키값과 코드값 쿼리스트링으로 저장. 
        String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code + "&key=" + key + "&value=" + value;

        //요청헤더 
        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", ApiCaptchaNkey.CLIENT_ID);
        requestHeaders.put("X-Naver-Client-Secret", ApiCaptchaNkey.CLIENT_SECRET);
        
        //응답 문서 저장. 
        String responseBody = ApiCaptchaNkeyResult.get(apiURL, requestHeaders);

        log.info(responseBody);
        Gson gson = new Gson();
        Captcha cap = gson.<Captcha>fromJson(responseBody, Captcha.class);
        
        String result = cap.getResult();
        
        //return responseBody;
        return result;
    }//

    private static String get(String apiUrl, Map<String, String> requestHeaders){
        
    	//connect 메서드 이용해 connection 객체 얻기. 
    	HttpURLConnection con = connect(apiUrl);
       
        try {
            
        	con.setRequestMethod("GET");	//get방식으로 요청 
            
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }//for

            int responseCode = con.getResponseCode();	//응답코드 저장. 
            
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출 상태코드 200.
                return readBody(con.getInputStream());
            } else { 										 // 에러 발생
                return readBody(con.getErrorStream());
            }//if-else
            
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();		//연결 해제 
        }//try-catch-finally
    
    }//get

    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);	//URL 객체 생성
        
            return (HttpURLConnection)url.openConnection();	//connection 객체 리턴
        
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }//try-catch
        
    }//connect

    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);

        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();

            String line;
            
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }//while

            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
        }//try-catch
        
    }//readBody
}//end class