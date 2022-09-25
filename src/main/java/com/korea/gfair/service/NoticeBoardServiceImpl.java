package com.korea.gfair.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.mapper.NoticeBoardMapper;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@NoArgsConstructor
@Service
public class NoticeBoardServiceImpl implements NoticeBoardService{

	@Setter(onMethod_ = @Autowired)
	private NoticeBoardMapper mapper;

	@Override
	public BoardVO readOne(BoardDTO dto) {
		//readCnt(dto);
		return mapper.select(dto);
	}

	@Override
	public boolean register(BoardDTO dto) {
		log.debug("register_service invoked.");
		boolean isSuccess = this.mapper.insert(dto);
		return isSuccess;
	}

	@Override
	public boolean modify(BoardDTO dto) {
		boolean isSuccess = this.mapper.update(dto);
		return isSuccess;
	}

	@Override
	public boolean remove(BoardDTO dto) {
		boolean isSuccess = this.mapper.delete(dto);
		return isSuccess;
	}

	@Override
	public List<BoardReplyCountVO> readNotice(String bname) {
		return this.mapper.getNotice(bname);
	}

	@Override
	public List<BoardReplyCountVO> getListPerPage(Criteria cri, String bname) {
		
		return this.mapper.list(cri, bname);
	}

	@Override
	public int getTotal(Criteria cri, String bname) {
		
		return this.mapper.totalCount(cri, bname);
	}



	@Override
	public boolean readCnt(BoardDTO dto) {
		
		boolean isSuccess = this.mapper.readcnt(dto);
		return isSuccess;
	}

	

    //=============================================
	// Answer 답변
	//=============================================
	@Override
	public boolean updateAnswer(BoardDTO dto) {
		return this.mapper.repStepUp(dto);
	}
	
	@Override
	public boolean writeAnswer(BoardDTO dto) {
		updateAnswer(dto);
		boolean isSuccess = this.mapper.repInsert(dto);
		
		return isSuccess;
	}

	



	
	
}
