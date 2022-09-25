package com.korea.gfair.domain;

import java.util.Date;

import lombok.Value;

@Value
public class PaymentVO {
	
	private Integer pno;
	private Integer btprice;
	
	private Date	pdate;
	private String	pstatus;
	
	private	Integer	btno;
	
}//end class
