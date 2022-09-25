package com.korea.gfair.service;

import java.util.List;

import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyVO;

public interface NoticeBoardReplyService {

	//INSERT REPLY
	public abstract boolean writeReply(ReplyDTO dto);
	//READ REPLY
	public abstract List<ReplyVO> getReply(ReplyDTO dto);
	//DEL REPLY
	public abstract boolean removeReply(ReplyDTO dto);
	//MODIFY REPLY
	public abstract void modifyReply(ReplyDTO dto);
}//end interface
