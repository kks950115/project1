package com.korea.gfair.domain;

import java.sql.Timestamp;

import lombok.Value;

//NyHyeonA
@Value
public class BoardSearchFileVO {

//	게시글정보
	private Integer bno;
	private Integer reproot;
	private Integer repstep;
	private Integer repindent;
	private String title;
	private String content;
	private String memberid;
	private Timestamp insert_ts;
	private Timestamp update_ts;
	private Integer readcnt;
	private String bname;
	private String public_tf;
	
	private Integer fid;
	
//	파일정보
	private String frename;//보관할 파일
	private String fpath;//업로드된 파일 경로
	private String forname;//원래파일명
}//end class
