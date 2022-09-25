package com.korea.gfair.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ReplyVO;

public interface BoardReplyMapper {

	
	public abstract List<ReplyVO> replyList(@Param("cri")Criteria cri, @Param("bno")Integer bno);
	public abstract ReplyVO replySelect(Integer reno);
	
	public abstract boolean replyInsert(ReplyVO reply);
	public abstract boolean replyDelete(Integer reno);
	public abstract boolean replyUpdate(@Param("reply")ReplyVO reply);
	
	public abstract Integer totalCount(Integer bno);
	public abstract List<BoardReplyCountVO> boardReplyCnt(@Param("cri")Criteria cri, @Param("bname")String bname);
}//end interface
