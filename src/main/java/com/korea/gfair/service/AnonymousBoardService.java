package com.korea.gfair.service;

import java.util.List;

import com.korea.gfair.domain.AttachFileDTO;
import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;



public interface AnonymousBoardService {

	
	public abstract List<BoardVO> getList(Criteria cri, String bname) throws Exception;
	public abstract BoardVO getSelect(Integer bno) throws Exception;
	
	public abstract boolean register(BoardDTO dto, AttachFileDTO fileDTO) throws Exception;
	public abstract boolean remove(BoardDTO dto) throws Exception;
	public abstract boolean modify(BoardDTO dto, AttachFileDTO fileDTO) throws Exception;
	
	public abstract Integer getTotalCount(Criteria cri, String bname) throws Exception;
	public abstract boolean readCount(Integer bno) throws Exception;
	
	public abstract boolean retrieve(BoardDTO dto, AttachFileDTO fileDTO) throws Exception;
}//end class
