package com.korea.gfair.domain;

import java.sql.Timestamp;

import lombok.Value;

@Value
public class ApplyFileVO {

	private Integer applyno;
	private Long cbno;
	private Integer fid;
	private String 	applycompany;
	private String	phone;
	private String 	email;
	private String	memberid;
	private String	payment_tf;
	private	String 	agrstate_tf;
	private	String	applyname;
	private Timestamp applydate;
	private	Integer pno;
	private	Integer	btno;
	
	private String frename;
	private String fpath;
	private String forname;
}//end class
