package com.korea.gfair.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;

@Service
public interface NewsBoardService {
	
	public abstract List<BoardVO> getList(Criteria cri);  // 리스트 조회 매서드

	public abstract boolean register(BoardVO board);
	
	public abstract boolean modify(BoardVO board); // 리스트 수정 
		
	public abstract boolean remove(Integer bno); // 삭제 메서드 
	
	public abstract BoardVO select(Integer bno); // 게시판 상세조회, 리턴타입이 VO 
	
	public abstract void hit(Integer readcnt);

	public abstract int getTotal(Criteria cri);


	}//BoardService  >> 인터페이스, 로직 기준으로 매서드 
