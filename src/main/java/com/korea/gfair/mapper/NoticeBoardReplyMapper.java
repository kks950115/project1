package com.korea.gfair.mapper;

import java.util.List;

import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyVO;

public interface NoticeBoardReplyMapper {

	
	public abstract List<ReplyVO> replyList(ReplyDTO dto);
	
	public abstract boolean replyInsert(ReplyDTO dto);
	public abstract boolean replyDelete(ReplyDTO dto);
	
	public abstract void updateReply(ReplyDTO dto);
	
}//end interface
