package com.korea.gfair.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;

public interface NewsBoardMapper {

	public abstract List<BoardVO> list(@Param("cri")Criteria cri, @Param("bname")String bname); 
	
	public abstract BoardVO select(Integer bno); // news 게시판을 상세 읽기 메서드 
	
	public abstract int delete(Integer bno); // news 항목 삭제
	
	public abstract int insert(BoardVO bno); // new 게시판에서 글 입력하는 메서드 
	
	public abstract int update(BoardVO bno); // news 게시판 글을 수정하는 메서드 
		
	public abstract int totalCount(@Param("cri")Criteria cri, @Param("bname")String bname); // 글 개수 

	public abstract void readcnt(int readcnt); // 조회수 

	public abstract void select(BoardVO board);
	
}// end newsBoardMapper 