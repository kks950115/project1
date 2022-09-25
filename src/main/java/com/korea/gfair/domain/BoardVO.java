package com.korea.gfair.domain;

import java.util.Date;

import lombok.Value;

@Value
public class BoardVO {
	
	private Integer bno;
	private Integer reproot;
	private Integer repstep;
	private Integer repindent;
	
	private String title;
	private String content;
	private String memberid;
	
	private Date insert_ts;
	private Date update_ts;
	
	private Integer readcnt;
	
	private String bname;
	
	private Integer fid;
	
	private String notice_tf;
	private String public_tf;
	private String reply_tf;

}//end class
