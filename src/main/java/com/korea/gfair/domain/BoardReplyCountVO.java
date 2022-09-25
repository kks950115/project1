package com.korea.gfair.domain;

import java.sql.Timestamp;

import lombok.Value;

//NyHyeonA
@Value
public class BoardReplyCountVO {
	
	private Integer bno;
	private Integer reproot;
	private Integer repstep;
	private Integer repindent;
	private String title;
	private String content;
	private String memberid;
	private Timestamp insert_ts;
	private Timestamp update_ts;
	private Integer readcnt;
	private String bname;
	private Integer fid;
	private String public_tf;
	
	private Integer renoCount;
	
}//end class
