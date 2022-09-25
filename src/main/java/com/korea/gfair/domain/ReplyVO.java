package com.korea.gfair.domain;

import java.util.Date;

import lombok.Value;

@Value
public class ReplyVO {

	private Integer reno;
	private Integer bno;
	private String recontent;
	private String memberid;
	private Date redate;
	
}//end class
