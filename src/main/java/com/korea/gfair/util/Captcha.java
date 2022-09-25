package com.korea.gfair.util;

import lombok.Data;

@Data
public class Captcha {

	private String key;
	private String result;
	private Double responseTime;
	private String value;
	private String imgPathAndName;
}//end class
