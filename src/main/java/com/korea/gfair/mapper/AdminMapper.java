package com.korea.gfair.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ReplyBoardVO;


public interface AdminMapper {

	//회원글 모두 조회
	public abstract List<BoardReplyCountVO> memberBoardList(Criteria cri) throws Exception;
	//전체글수
	public abstract Integer memberBoardTotalCount(Criteria cri) throws Exception;
	//선택삭제
	public abstract boolean memberBoardDelete(@Param("bnoList")List<Integer> bnoList) throws Exception;
	
	//회원댓글 모두 조회
	public abstract List<ReplyBoardVO> memberReplyList(Criteria cri) throws Exception;
	//전체댓글수
	public abstract Integer memberReplyTotalCount(Criteria cri) throws Exception;
	//선택댓글삭제
	public abstract boolean memberReplyDelete(@Param("renoList")List<Integer> renoList) throws Exception;
	
	public abstract Integer selectPaymentCheckInt(List<Integer> applynoList) throws Exception;
}//end interface
