package com.korea.gfair.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.persistence.BoardDAO;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;


@NoArgsConstructor
@Log4j2

@Service
public class QuestionBoardServiceImpl implements QuestionBoardService {

	@Setter(onMethod_ = @Autowired)
	BoardDAO dao;
	
	@Override
	public List<BoardVO> getAllList(Criteria cri) throws Exception {
		log.debug("getAllList() invoked.");
		
		List<BoardVO> list =this.dao.selectAllList(cri);
		
		return list;
	}//getAllList
	
	@Override
	public BoardVO getOneList(BoardDTO dto) throws Exception{
		log.debug("getOneList({}) invoked.", dto);
		
		BoardVO list = this.dao.selectOneList(dto);
		
		return list;
	}//getOneList

	@Override
	public boolean modify(BoardDTO dto) throws Exception {
		log.debug("modify({}) invoked.", dto);
		
		return this.dao.updateList(dto);
	}//modify

	@Override
	public boolean remove(BoardDTO dto) throws Exception {
		log.debug("remove({}) invoked.", dto);
		return this.dao.delete(dto);
	}

	@Override
	public boolean register(BoardDTO dto) throws Exception {
		log.debug("register({}) invoked.", dto);
		
		
//		----------------------------------------------------------
//		default settings
//		----------------------------------------------------------
		dto.setBname("question");
		dto.setNotice_tf("F");

		
//		새글 작성시에는 무조건 F 답글 작성시에 변경
		dto.setReply_tf("F");
		
		
		return this.dao.insert(dto);
	}//remove

	@Override
	public boolean retrieve(BoardDTO dto) throws Exception {
		log.debug("retrieve({}) invoked.", dto);
		
		return this.dao.insertRetreive(dto);
	}//retrieve

	@Override
	public int getTotal(Criteria cri) throws Exception {
		
		return this.dao.selectTotalCount(cri);
	}//getTotal

	
	
}//end class
