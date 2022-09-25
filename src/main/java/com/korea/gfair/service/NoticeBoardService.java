package com.korea.gfair.service;

import java.util.List;

import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;

public interface NoticeBoardService {

	public abstract BoardVO readOne(BoardDTO dto);
	public abstract List<BoardReplyCountVO> readNotice(String bname);
	public abstract boolean register(BoardDTO dto);
	public abstract boolean modify(BoardDTO dto);
	public abstract boolean remove(BoardDTO dto);
	
	
	public abstract List<BoardReplyCountVO> getListPerPage(Criteria cri, String bname);

	public abstract int getTotal(Criteria cri, String bname);
	
	
	public abstract boolean readCnt(BoardDTO dto);
	
	
	
	
	//Answer 답변
	public abstract boolean updateAnswer(BoardDTO dto);
	public abstract boolean writeAnswer(BoardDTO dto);
	
	


}
