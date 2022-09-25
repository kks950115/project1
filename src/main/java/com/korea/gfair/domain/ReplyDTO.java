package com.korea.gfair.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyDTO {
	
	private Integer reno;		//댓글번호
	private Integer bno;		//글번호
	private String recontent;	//댓글내용
	private String memberid;	//작성자
	private Date redate;		//작성시간

	
}//end class
