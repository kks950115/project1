package com.korea.gfair.service;

import java.util.List;

import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyVO;

public interface FreeBoardReplyService {
	
	public abstract List<ReplyVO> readReply(ReplyDTO rdto); //댓글 리스트 조회
	public abstract void writeReply(ReplyDTO rdto);			//댓글 작성
	public abstract void modifyReply(ReplyDTO dto);			//댓글 수정
	public abstract void deleteReply(ReplyDTO dto);			//댓글 삭제
	public abstract void countReply(ReplyDTO dto);			//댓글 갯수
	

}//end interface
