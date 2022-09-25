package com.korea.gfair.service;

import java.util.List;

import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;

public interface QuestionBoardService {

	public List<BoardVO> getAllList(Criteria cri) throws Exception ;
	
	public BoardVO getOneList(BoardDTO dto) throws Exception;
	
	public boolean modify(BoardDTO dto) throws Exception;
	public boolean remove(BoardDTO dto) throws Exception;
	public boolean register(BoardDTO dto) throws Exception;
	public boolean retrieve(BoardDTO dto) throws Exception;
	
	public abstract int getTotal(Criteria cri) throws Exception;
	
}//end interface
