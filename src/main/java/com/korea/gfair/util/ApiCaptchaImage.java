package com.korea.gfair.util;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

// 네이버 캡차 API 2.- 캡차 이미지 수신
public class ApiCaptchaImage {

	// ApiCaptchaNKey에서 발급받은 Key를 매개변수로 전달. 
	// 즉, https://openapi.naver.com/v1/captcha/nkey 호출로 받은 키값
    public static String getImageRequest(String key) { 
    	log.debug("getImage({}) invoked.", key);

       
        String apiURL = "https://openapi.naver.com/v1/captcha/ncaptcha.bin?key=" + key;

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", ApiCaptchaNkey.CLIENT_ID);
        requestHeaders.put("X-Naver-Client-Secret", ApiCaptchaNkey.CLIENT_SECRET);
        String responseBody = ApiCaptchaImage.get(apiURL,requestHeaders);

        log.info(responseBody);
        
        return responseBody;
    }//getImage

    private static String get(String apiUrl, Map<String, String> requestHeaders){
        log.debug("get({},{}) invoked.", apiUrl, requestHeaders);
    	
    	HttpURLConnection con = ApiCaptchaImage.connect(apiUrl);	//connect 메서드를 이용해 Connection 객체 얻기. 
        
    	try {
            con.setRequestMethod("GET");	//request method는 Get방식으로 요청. 
            
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }//for

            int responseCode = con.getResponseCode();	//응답코드 저장. 
            
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출 상태코드 200.
                return ApiCaptchaImage.getImage(con.getInputStream());		 //정상호출일때만 이미지 얻기
            } else { // 에러 발생
                return ApiCaptchaImage.error(con.getErrorStream());
            }//if-else
            
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }//try-catch-finally
    
    }//get

    private static HttpURLConnection connect(String apiUrl){		//apiUrl로 Connection 객체를 얻는 메소드
        log.debug("connect({}) invoked.", apiUrl);
    	
    	try {
            URL url = new URL(apiUrl);				//apiUrl로 URL 객체 생성
            return (HttpURLConnection)url.openConnection();	//URL객체로 HttpURLConnection를 얻어 리턴
        
    	} catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }//try-catch
    	
    }//connect

    private static String getImage(InputStream is){
        
    	int read;
        
        byte[] bytes = new byte[1024];		//바가지 
        
        // 랜덤한 이름으로  파일 생성
        String filename = Long.valueOf(new Date().getTime()).toString();
        
        
        LocalDate todaysDate = LocalDate.now(); // 현재 날짜 얻기. 
        
        String filePath = todaysDate+"/";   //날짜별로 저장할 폴더 경로
        //String fullPath="C:/OPT/eclipse/workspace/JEE/gfair2/src/main/webapp/resources/captcha/"+filePath; 
        String fullPath = "C:/opt/eclipse/workspace/JEE/G-FAIR-BACKEND/src/main/webapp/resources/captcha/" + filePath;
        
        File f = new File(fullPath);
        
        if(!f.isDirectory()){    //만약 경로에 지정된 폴더가 없으면
        	f.mkdirs();          //폴더 새로 만들기 
        	log.debug("*****************mkdirs invoked.");
        }//if
        
        try(OutputStream outputStream = new FileOutputStream(fullPath+filename + ".jpg")){
            
        	f.createNewFile();
            
            while ((read = is.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }//while
            
            return filePath+filename+".jpg";
        } catch (IOException e) {
            throw new RuntimeException("이미지 캡차 파일 생성에 실패 했습니다.",e);
        }//try-catch
        
    }//getImage

    private static String error(InputStream body) {
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
        
    }//error
}//end class