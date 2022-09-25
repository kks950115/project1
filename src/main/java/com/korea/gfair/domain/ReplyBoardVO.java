package com.korea.gfair.domain;

import java.sql.Timestamp;

import lombok.Value;

//NyHyeonA
@Value
public class ReplyBoardVO {

	private Integer	reno; 
	private Integer bno;
	private String 	recontent;
	private String memberid;
	private	Timestamp redate;
	
	private Integer reproot;
	private Integer repstep;
	private Integer repindent;
	private String title;
	private String content;
	private String writer;
	private Integer readcnt;
	private String bname;
	
}//end class
