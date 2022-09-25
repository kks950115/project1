package com.korea.gfair.domain;

import lombok.Value;

@Value
public class ApplyVO {

	private Integer applyno; //참가번호
	private Long cbno; //사업자등록번호
	private Integer fid;
	
	private String 	applycompany;// 회사이름
	private String	phone;
	private String 	email;
	private String	memberid; //아이디
	
	private String	payment_tf;
	private	String 	agrstate_tf;
	
	private	String	applyname;
	
	private	Integer pno; //결제번호
	private	Integer	btno; //부스번호
}//end class
