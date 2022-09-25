package com.korea.gfair.service;

import java.util.List;

import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ReplyPageDTO;

import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyVO;

public interface ReplyService {

	public List<ReplyVO> getReply(ReplyDTO dto) throws Exception;
	public boolean registerReply (ReplyDTO dto) throws Exception;
	public boolean removeReply(ReplyDTO dto) throws Exception;
	
	
	//-------------- danny ----------------//
	
	public abstract int register(ReplyDTO dto);
	
	public abstract ReplyVO get(Integer reno);
	
	public abstract int modify(ReplyDTO dto);
	
	public abstract int remove(Integer reno);
	
	public abstract List<ReplyVO> getList(Criteria cri, Integer bno);
	
	public abstract ReplyPageDTO getListPerPage(Criteria cri, Integer bno);
}//end interface
