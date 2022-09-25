package com.korea.gfair.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;
import lombok.extern.log4j.Log4j2;

@Log4j2
//Java Beans Object
@Data
public class Criteria {	//페이징 처리를 위해 기준 값을 저장하는 용도의 클래스 
						//그리고 이 기준 클래스를 앞으로 만든 DTO 클래스에서 사용하자!!! 
	
	private int currPage =1;
	private int amount=10;
	private int pagesPerPage =10;
	
	private String type;		//검색유형
	private String keyword;		//검색어
	
	private String bname;
//	private String bnameKeyWord;
	   
	   public String getPagingUri() {
	      log.debug("getPagingUri() invoked");
	      
	      UriComponentsBuilder builder = UriComponentsBuilder.fromPath("");
	      builder.queryParam("currPage", this.currPage);
	      builder.queryParam("amount", this.amount);
	      builder.queryParam("pagesPerPage", this.pagesPerPage);
	      builder.queryParam("type", this.type);
	      builder.queryParam("keyword", this.keyword);
	      
	      log.info("\t+ pagingUri:"+builder.toUriString());
	      return builder.toUriString();
	   }//getPagingUri
	
	
}//end class
