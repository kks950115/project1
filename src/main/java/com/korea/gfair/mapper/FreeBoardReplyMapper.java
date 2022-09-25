package com.korea.gfair.mapper;

import java.util.List;

import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyVO;

public interface FreeBoardReplyMapper {
	
	public abstract List<ReplyVO> selectReply(ReplyDTO rdto);	//댓글 리스트 조회
	public abstract void insertReply(ReplyDTO dto);				//댓글 작성
	public abstract ReplyVO updateReply(ReplyDTO dto);			//댓글 수정
	public abstract void deleteReply(ReplyDTO dto);				//댓글 삭제
	public abstract void countReply(ReplyDTO dto);				//댓글 갯수
	
}
