package com.korea.gfair.domain;

import java.util.Date;

import lombok.Value;

@Value
public class BoardReplyJoinVO {

	private String 	bname;
	private Integer	bno; 
	private Integer	reno; 
	private String 	recontent;
	private String	memberid; 
	private	Date	redate;
}//end class
