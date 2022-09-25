package com.korea.gfair.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberDTO {

	private Integer mno;
	private String	memberid;
	private String 	memberpw;
	private String 	membername;
	private String 	memberaddress;
	private String 	phone;
	private String 	email;
	private Long	cbno;
	private	Integer	fid;
	private	Date	signdate;
	private String	drop_tf;
	private Date	dropdate;
	private String 	membertype;
	
}//end class
