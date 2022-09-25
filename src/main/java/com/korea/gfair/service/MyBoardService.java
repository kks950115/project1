package com.korea.gfair.service;

import java.util.List;

import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.Criteria;


public interface MyBoardService {

	public abstract List<BoardReplyCountVO> getList(Criteria cri, String memberid) throws Exception;
	
	public abstract Integer getTotalCount(Criteria cri, String memberid) throws Exception;
	
	public abstract void selectAllRemove(List<Integer> bnoList, String memberid) throws Exception;
}//end interface
