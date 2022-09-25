package com.korea.gfair.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;

public interface FreeBoardMapper {
	
	public abstract List<BoardVO> getListWithPaging(@Param("cri")Criteria cri ,@Param("bname")String bname);	//페이징 처리 된 게시판 목록조회
	public abstract int getTotalCount(@Param("cri")Criteria cri,@Param("bname")String bname); 					//게시판 총 레코드 건수 얻기
	
	public abstract BoardVO select(BoardDTO dto);	//자세히 보기
	public abstract boolean insert(BoardVO vo);		//새로운 글 작성
	public abstract boolean update(BoardDTO dto);	//글 수정하기
	public abstract boolean delete(Integer bno);	//특정 게시글 삭제
	public abstract void readcnt(BoardDTO dto);		//조회수
	
	
}//end interface
