package com.korea.gfair.domain;

import java.sql.Timestamp;

import lombok.Data;


@Data
public class ExhibitionDTO {

	
	private Integer exno;
	private String exname;
	private String exstart;
	private String exend;
	private String excontent;
	private Timestamp exinsert;
	private Timestamp exupdate;
	
}//end class
