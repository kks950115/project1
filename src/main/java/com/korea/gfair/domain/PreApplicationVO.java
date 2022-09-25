package com.korea.gfair.domain;

import java.util.Date;

import lombok.Value;

@Value
public class PreApplicationVO {
	private Integer appno;
	private Integer exno;
	private String appname;
	private Date appdate;
	private String applyer;
	private String memberid;
	private String phone;
	
}//end class
