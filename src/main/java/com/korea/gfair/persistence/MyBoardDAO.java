package com.korea.gfair.persistence;

import java.util.List;

import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.Criteria;


public interface MyBoardDAO {

	public abstract List<BoardReplyCountVO> list(Criteria cri, String memberid) throws Exception;
	
	public abstract Integer totalCount(Criteria cri, String memberid) throws Exception;//내가 쓴 글 게시판의 총 개수
	
	public abstract void delete(List<Integer> bnoList, String memberid) throws Exception;//선택한것 모두 삭제
}//end interface
