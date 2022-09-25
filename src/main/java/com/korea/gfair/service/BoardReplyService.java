package com.korea.gfair.service;

import java.util.List;

import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyPageDTO;
import com.korea.gfair.domain.ReplyVO;

public interface BoardReplyService {

	
	public abstract ReplyPageDTO getReplyList(Criteria cri, Integer bno);
	public abstract ReplyVO replyGet(Integer reno);
	
	public abstract boolean replyRegister(ReplyDTO replyDTO);
	public abstract boolean replyModify(ReplyDTO replyDTO);
	public abstract boolean replyRemove(Integer bno);
	
	public abstract Integer getTotalCount(Integer bno);
	public abstract List<BoardReplyCountVO> getBoardReplyCnt(Criteria cri, String bname);
}//end interface
