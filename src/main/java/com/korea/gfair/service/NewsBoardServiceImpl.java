package com.korea.gfair.service;

import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.mapper.NewsBoardMapper;

import lombok.extern.log4j.Log4j2;

@Log4j2
//@AllArgsConstructor

@Service
public class NewsBoardServiceImpl implements NewsBoardService{

	@Autowired
	private NewsBoardMapper mapper;
	
	@Override
	public boolean modify(BoardVO board) {
		log.info("modify() invoked");
		
		Objects.requireNonNull(this.mapper);
		
		return (this.mapper.update(board)) ==1;
	}

	@Override
	public boolean remove(Integer bno) {
	log.info("remove() invoked");
		
		Objects.requireNonNull(this.mapper);
		
		return (this.mapper.delete(bno)) ==1;
	}

	@Override
	public BoardVO select(Integer bno) {
		
		log.info("get(Integer bno) invoked");
		
		Objects.requireNonNull(this.mapper);
		
		return this.mapper.select(bno);
	}

	@Override
	public boolean register(BoardVO board) {
		log.info("register(newsBoardVO board) invoked");
		
		Objects.requireNonNull(this.mapper);
		
		return (this.mapper.insert(board))==1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		

		log.info("getList()");
		
		Objects.requireNonNull(this.mapper);
		
		return mapper.list(cri, "보도자료");
	}
	
	@Override
	public int getTotal(Criteria cri) {
	
		Objects.requireNonNull(this.mapper);
//		Criteria cri = new Criteria();
		return mapper.totalCount(cri, "보도자료");
	}

	@Override
	public void hit(Integer readcnt) {
		
		log.info("hit() invoked ");
		
		Objects.requireNonNull(this.mapper);
		
		 this.mapper.readcnt(readcnt);
	}

}//end newsBoardVOServiceImpl
