package com.korea.gfair.domain;

import java.util.Date;

import lombok.Value;

@Value
public class MemberVO {

	private Integer mno;
	private String 	membertype;
	private String	drop_tf;
	private Date	dropdate;
	private String	memberid;
	private String 	memberpw;
	private String 	membername;
	private String 	memberaddress;
	private String 	phone;
	private String 	email;
	private Long	cbno;
	private	Integer	fid;
	private	Date	signdate;
	
	
	
	
}//end class
