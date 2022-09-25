package com.korea.gfair.util;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.google.gson.Gson;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2
public class HomeTaxCBNO {
	
	public static Double homeTaxCBNO(String cbno) throws ClientProtocolException, IOException {
		
		/*
		=======================
		** 1. 디펜던시 추가 필요 **
		=======================
		
	    <!-- httpclient -->
	    <dependency>
	      <groupId>org.apache.httpcomponents</groupId>
	      <artifactId>httpclient</artifactId>
	      <version>4.5.13</version>
	    </dependency> 
	    
	    
		*/
		
		
		CloseableHttpClient client = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost("https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=SaEtDV6V2ezASF4OroNIlotaYMp84VVz%2BYxZ%2BFvB9MlN%2F7DSCPLNnNRRTZrFKSffpip1B4BvtocfTS08%2F6Hm1Q%3D%3D");
		
		try(client) {
			//String input = Long.toString(dto.getCbno());
			//String input = "2150893029"; //사업자등록번호
			String input = cbno; //사업자등록번호
			
			String json = "{ \"b_no\":[\""+ input +"\"]}";
			StringEntity entity = new StringEntity(json);
			
			httpPost.setEntity(entity);
			httpPost.setHeader("Content-type", "application/json");
			
			CloseableHttpResponse response = client.execute(httpPost);
			
			try(response) {
				//HttpStatus 상태코드
				log.info("STATUS : " + response.getStatusLine().getStatusCode());
				
				//응답 결과값 출력
				HttpEntity print = response.getEntity();
				String result = EntityUtils.toString(print);
				log.info(result);
				
				Gson gson = new Gson();
				Map<String, Double> map = new HashMap<String, Double>();
				
				//JSON을 JAVA객체로 변환
				map = (Map<String, Double>) gson.fromJson(result, map.getClass());
				log.info("결과값 : " + map.get("match_cnt"));
				
				//return 값 1.0 나오면 국세청에 등록된 사업자 번호라는뜻
				return (Double) map.get("match_cnt");
				
			}//try-with-resources
			
			
		}//try-with-resources
		
		
	}//end
	

}
