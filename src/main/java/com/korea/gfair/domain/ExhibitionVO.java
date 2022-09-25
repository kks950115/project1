package com.korea.gfair.domain;

import java.util.Date;

import lombok.Value;

@Value
public class ExhibitionVO {

	private Integer exno; 
	private String 	exname; 
	private Date 	exstart;
	private Date 	exend;
	private String 	excontent;
	private Date 	exinsert;
	private Date	exupdate;
	
}//end class
