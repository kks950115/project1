package com.korea.gfair.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {

	private int replyCnt;
	private List<ReplyVO> list;
	
	
}//end class
